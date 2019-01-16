module FoldersHelper
  # roomインスタンスまたはfolderインスタンスで表示するくらすを返す
  def display_icon_status(resource)
    resource.is_a?(Folder) ? 'glyphicon-folder-close' : 'glyphicon-list-alt'
  end

  # 編集へのリダイレクトパス
  # roomインスタンスまたはfolderインスタンスでパスを分ける
  def change_instance_redirect(resource)
    resource.is_a?(Folder) ? edit_folder_path(resource) : edit_room_path(resource)
  end
end
