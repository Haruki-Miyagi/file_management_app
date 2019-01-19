class FoldersController < ApplicationController
  include CrudActionsMixin

  def index
    @resource = Folder.summit
    @resources = @resource.all_childrens.sort_by { |r, _| r.created_at }.reverse
  end

  def show
    @resources = @resource.all_childrens.sort_by { |r, _| r.created_at }.reverse
    @root_below_folder = @resource.root_below_folder
  end

  private

  def resource_params
    params.require(:folder).permit(:name, :description, :ancestry, :parent_id, :user_id)
  end

  def new_resource
    @resource = model_name.new(parent_id: params[:parent_id])
  end
end
