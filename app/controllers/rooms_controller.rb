class RoomsController < ApplicationController
  include CrudActionsMixin

  private

  def resource_params
    params.require(:room).permit(:name, :description, :user_id, :folder_id)
  end
end
