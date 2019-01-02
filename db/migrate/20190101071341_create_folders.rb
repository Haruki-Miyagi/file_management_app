class CreateFolders < ActiveRecord::Migration[5.2]
  def change
    create_table :folders do |t|
      t.string :name,        null: false, index: true
      t.text   :description,              index: true
      t.string :ancestry,                 index: true
      t.references :user,                              foreign_key: true

      t.timestamps
    end
  end
end
