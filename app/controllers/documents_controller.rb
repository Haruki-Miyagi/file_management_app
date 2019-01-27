class DocumentsController < ApplicationController
  include CrudActionsMixin

  private

  def resource_params
    documents_params = params.require(:document).permit(:file_name, :file_date, :description, :user_id, :room_id)
    UploadFileService.new(documents_params).define_params
  end

  def new_resource
    @room = Room.find(params[:room_id])
    @resource = model_name.new
  end
end
