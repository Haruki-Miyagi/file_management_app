class FoldersController < ApplicationController
  before_action :set_folder, only: [:show]

  def index
    @folder = Folder.summit
  end

  def show; end

  private

  def set_folder
    @folder = Folder.find(params[:id])
  end
end
