class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :name,        null: false, index: true
      t.text   :description,              index: true
      t.references :folder,                            foreign_key: true
      t.references :user,                              foreign_key: true

      t.timestamps
    end
  end
end
