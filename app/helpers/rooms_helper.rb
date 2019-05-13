module RoomsHelper
  def like_room?(room)
    UserControllRoom.find_by(user_id: current_user, room_id: room.id).present?
  end
end
