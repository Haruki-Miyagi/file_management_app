# テスト用に権限userの作成
# フォルダ[tree上のtopフォルダ(rootフォルダ)]
def admin_user
  user_id = 1
  user = User.create(
    email: "admin#{user_id}@admin.com",
    password: '1234567890',
    password_confirmation: '1234567890',
    admin: true
  )

  Folder.create(
    name: 'Root',
    description: 'Root Folder',
    user_id: user.id
  )
end

# rootフォルダ下のフォルダの作成
def sub_folder
  root = Folder.first
  user = User.first

  for folder_id in 1..5
    root01 = tree_folder(root, user, folder_id)
    for folder_id in 1..6
      folder02 = tree_folder(root01, user, folder_id)
      for folder_id in 1..4
        folder03 = tree_folder(folder02, user, folder_id)
        for folder_id in 1..2
          folder04 = tree_folder(folder03, user, folder_id)
        end
      end
    end
  end
end

def tree_folder(folder, user, folder_id)
  folder.children.create(name: "folder#{folder_id}", description: "description#{folder_id}", user_id: user.id)
end

admin_user
sub_folder
