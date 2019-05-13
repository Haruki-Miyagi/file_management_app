class UserControllRoomsController < ApplicationController
  before_action :set_resource, only: %i[destroy]
  before_action :redirect_path_for_crud, only: %i[create destroy]

  def create
    user_id = current_user.id
    room_id = params[:room_id]

    respond_to do |format|
      if UserControllRoom.create(user_id: user_id, room_id: room_id)
        format.html { redirect_to @redirect_path, notice: 'お気に入りに登録しました。' }
      end
    end
  end

  def destroy
    @resource.destroy

    respond_to do |format|
      format.html { redirect_to @redirect_path, notice: 'お気に入りを解除しました。' }
    end
  end

  private

  def model_name
    self.class.to_s.gsub!('sController', '').constantize
  end

  def set_resource
    @resource = model_name.find(params[:id])
  end

  # リダイレクトパスを指定する
  def redirect_path_for_crud
    @redirect_path = request.referer.presence || folders_path
  end
end
