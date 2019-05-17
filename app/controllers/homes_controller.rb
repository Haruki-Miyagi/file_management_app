class HomesController < ApplicationController
  def index
    @resources = current_user.pending_rooms.order(:id)
  end
end
