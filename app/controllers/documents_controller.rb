class DocumentsController < ApplicationController
  include CrudActionsMixin

  private

  def resource_params
    UploadFileService.new(params[:document]).define_params
  end

  def new_resource
    @room = Room.find(params[:room_id])
    @resource = model_name.new
  end
end
