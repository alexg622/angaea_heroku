class CreateVenues < ActiveRecord::Migration[5.2]
  def change
    create_table :venues do |t|
      t.string :venue_name, null: false
      t.string :address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.integer :user_id
      t.integer :price, null: false
      t.string :capacity, null: false

      t.timestamps
    end
    add_index :venues, [:user_id]
  end
end
