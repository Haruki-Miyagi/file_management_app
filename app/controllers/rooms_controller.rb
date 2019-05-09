class RoomsController < ApplicationController
  include CrudActionsMixin

  def show
    @messages = @resource.messages
    @documents = @resource.documents.order_by_preference.paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.js { render partial: 'rooms/rooms_pagination_page' }
    end
  end

  private

  def resource_params
    params.require(:room).permit(:name, :description, :user_id, :folder_id)
  end

  def new_resource
    @resource = model_name.new(folder_id: params[:folder_id])
  end
end
