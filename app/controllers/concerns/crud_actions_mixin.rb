module CrudActionsMixin
  extend ActiveSupport::Concern

  included do
    before_action :set_resources, only: %i[show]
    before_action :new_resource, only: %i[new create]
  end

  def index
    @resources = model_name.order_by_preference
  end

  def show; end

  def new
    respond_to do |format|
      format.js
    end
  end

  def create
    @resource.attributes = resource_params

    respond_to do |format|
      if @resource.save
        redirect_path = request.referer.presence || { action: :index }
        format.html { redirect_to redirect_path, notice: '新しく作成しました。' }
      else
        format.js { render :new }
      end
    end
  end

  private

  def model_name
    self.class.to_s.gsub!('sController', '').constantize
  end

  def set_resources
    @resource = model_name.find(params[:id])
  end

  def new_resource
    @resource = model_name.new
  end
end
