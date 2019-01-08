class FoldersController < ApplicationController
  before_action :resource_folder, only: [:show]

  def index
    @folder = Folder.summit
  end

  def show; end

  private

  def resource_folder
    @folder = Folder.find(params[:id])
  end
end
