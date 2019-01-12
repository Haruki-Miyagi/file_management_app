module CrudActionsMixin
  extend ActiveSupport::Concern

  included do
    before_action :set_resources, only: %i[show]
  end

  def show; end

  private

  def model_name
    self.class.to_s.gsub!('sController', '').constantize
  end

  def set_resources
    @resource = model_name.find(params[:id])
  end
end
