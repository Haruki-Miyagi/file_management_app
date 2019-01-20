# frozen_string_literal: true

module ApplicationCable
  class Connection < ActionCable::Connection::Base
    # コネクションを識別するキー
    # つまりログイン時に設定したCookieを取り出す
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    protected

    def find_verified_user
      if (current_user = env['warden'].user)
        current_user
      else
        # 404を返す
        reject_unauthorized_connection
      end
    end
  end
end
