class CreateRentals < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.string :cost, null: false
      t.string :rental_name, null: false
      t.text :description, null: false
      t.string :category
      t.text :additional_info
      t.string :contact_number
      t.string :contact_email, null: false
      t.string :addressLN1, null: false
      t.string :addressLN2
      t.string :state, null: false
      t.string :city, null: false
      t.string :zipcode, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false 
      t.integer :user_id

      t.timestamps
    end
    add_index :rentals, :user_id
  end
end
