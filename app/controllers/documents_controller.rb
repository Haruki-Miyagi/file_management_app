class DocumentsController < ApplicationController
  include CrudActionsMixin

  private

  def resource_params
    params.require(:document).permit(:file_name, :uploaded_file, :description, :user_id, :room_id)
  end

  def new_resource
    @room = Room.find(params[:room_id])
    @resource = model_name.new
  end
end
