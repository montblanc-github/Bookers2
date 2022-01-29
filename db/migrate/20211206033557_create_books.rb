class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.text :title, null: false
      t.text :body, null: false
      t.integer :user_id, null: false
      t.float :rate, null: false
      t.string :category, null: false

      t.timestamps
    end
  end
end
