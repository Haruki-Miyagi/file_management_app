class CreateUserControllRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :user_controll_rooms do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.index [:user_id, :room_id], unique: true

      t.timestamps
    end
  end
end
