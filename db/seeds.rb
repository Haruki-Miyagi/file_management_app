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

admin_user
