# https://github.com/lassebunk/gretel
# パンくずリストの追加

# Root crumb
crumb :root do
  link "Home", folders_path
end

# フォルダ詳細のパンくず
crumb :folder do |resources|
  resources.each do |folder|
    link folder.name, "/folders/#{folder.id}"
    parent :root
  end
end

# フォルダ詳細のパンくず
crumb :room do |resource|
  resource.folder.root_below_folder.each do |folder|
    link folder.name, "/folders/#{folder.id}"
    parent :root
  end

  link resource.name, "/rooms/#{resource.id}"
  parent :root
end
