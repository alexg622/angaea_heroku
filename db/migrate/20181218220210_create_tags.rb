class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.integer :activity_id
      t.integer :category_id

      t.timestamps
    end
    add_index :tags, :activity_id
    add_index :tags, :category_id
  end
end
