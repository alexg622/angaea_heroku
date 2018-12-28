class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :category_name, null: false
      t.integer :user_id

      t.timestamps
    end
    add_index :categories, :user_id
    add_index :categories, :category_name, unique: true 
  end
end
