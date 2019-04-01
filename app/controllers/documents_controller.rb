class DocumentsController < ApplicationController
  include CrudActionsMixin

  before_action :set_resource, only: %i[show edit update destroy download] # rubocop:disable Rails/LexicallyScopedActionFilter

  def download
    send_file(@resource.uploaded_file.current_path)
  end

  private

  def resource_params
    documents_params = params.require(:document).permit(:file_name, :file_date, :description, :user_id, :room_id)
    UploadFileService.new(documents_params).define_params
  end

  def set_resource
    @resource = model_name.find(params[:id])
    @room = @resource.room
  end

  def new_resource
    @room = Room.find(params[:room_id])
    @resource = model_name.new
  end
end
