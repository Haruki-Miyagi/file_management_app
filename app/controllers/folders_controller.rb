class FoldersController < ApplicationController
  include CrudActionsMixin

  def index
    @resource = Folder.summit
    @resources = @resource.children.order_by_preference
  end

  def show
    @resources = @resource.children.order_by_preference
    @root_below_folder = @resource.path.unset_root
  end

  private

  def resource_params
    params.require(:folder).permit(:name, :description, :ancestry, :parent_id, :user_id)
  end

  def new_resource
    @resource = model_name.new(parent_id: params[:parent_id])
  end
end
