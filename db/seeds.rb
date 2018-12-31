# テスト用に権限userの作成
# フォルダ[tree上のtopフォルダ(rootフォルダ)]
def admin_user
  user_id = 1
  User.create(
    email: "test#{user_id}@test.com",
    password: '1234567890',
    password_confirmation: '1234567890',
    admin: true
  )
end

admin_user
