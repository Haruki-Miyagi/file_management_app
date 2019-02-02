require 'rails_helper'

RSpec.describe MessageBroadcastJob, type: :job do
  include ActiveJob::TestHelper
  let(:message) { create(:message) }

  describe 'perform' do
    before { clear_enqueued_jobs }

    it 'ジョブをキューに入れること' do
      message = 'test-content'
      expect { MessageBroadcastJob.perform_later(message) }
        .to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
    end

    it 'is in default queue' do
      expect(described_class.new.queue_name).to eq('default')
    end

    it 'matches with enqueued job' do
      expect { described_class.perform_later }.to have_enqueued_job(described_class)
    end

    it 'executes perform' do
      server_double = double('server', broadcast: nil)
      renderer_double = double('renderer', render: 'test-content')
      allow(ActionCable).to receive(:server).and_return(server_double)
      allow(ApplicationController).to receive(:renderer).and_return(renderer_double)

      perform_enqueued_jobs do
        MessageBroadcastJob.perform_later(message)
      end

      expect(server_double).to have_received(:broadcast).with(
        "room_channel_#{message.room_id}",
        message: 'test-content'
      ).at_least(:once)

      expect(renderer_double).to have_received(:render).with(
        partial: 'messages/message',
        locals: { message: message }
      ).at_least(:once)
    end

    after do
      clear_enqueued_jobs
      clear_performed_jobs
    end
  end
end
