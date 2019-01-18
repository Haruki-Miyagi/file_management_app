class CreateDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :documents do |t|
      t.string :file_name,     null: false, index: true
      t.string :uploaded_file, null: false
      t.text :description,                  index: true
      t.references :user,                   index: true, foreign_key: true
      t.references :room,                   index: true, foreign_key: true

      t.timestamps
    end
  end
end
