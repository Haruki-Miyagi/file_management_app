class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.text :content,    null: false
      t.references :user,              index: true, foreign_key: true
      t.references :room,              index: true, foreign_key: true

      t.timestamps
    end
  end
end
