class FoldersController < ApplicationController
  include CrudActionsMixin

  def index
    @root_folder = Folder.summit
    @resources = @root_folder.children.order_by_preference
  end

  def show
    @resources = @resource.children.order_by_preference
  end
end
