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
