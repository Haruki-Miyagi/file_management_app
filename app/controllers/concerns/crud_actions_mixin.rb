module CrudActionsMixin
  extend ActiveSupport::Concern

  included do
    before_action :set_resource, only: %i[show edit update]
    before_action :new_resource, only: %i[new create]
    before_action :redirect_path_for_create_update, only: %i[create update]
  end

  def show; end

  def new
    respond_to do |format|
      format.js
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
  end

  def create
    @resource.attributes = resource_params

    respond_to do |format|
      if @resource.save
        format.html { redirect_to @redirect_path, notice: '新しく作成しました。' }
      else
        format.js { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @resource.update(resource_params)
        format.html { redirect_to @redirect_path, notice: '正常に更新しました。' }
      else
        format.js { render :edit }
      end
    end
  end

  private

  def model_name
    self.class.to_s.gsub!('sController', '').constantize
  end

  def set_resource
    @resource = model_name.find(params[:id])
  end

  def new_resource
    @resource = model_name.new
  end

  # レコードを保存できたときのリダイレクトパスを指定する
  # create、updateで保存が行われるため
  def redirect_path_for_create_update
    @redirect_path = request.referer.presence || { action: :index }
  end
end
