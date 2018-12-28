class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :ratings do |t|
      t.integer :user_id, null: false
      t.integer :activity_id, null: false
      t.integer :stars, null: false
      t.text :comment

      t.timestamps
    end
    add_index :ratings, :user_id
    add_index :ratings, :activity_id
  end
end
