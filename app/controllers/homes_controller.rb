class HomesController < ApplicationController
  def index
    @resources = current_user.pending_rooms
  end
end
