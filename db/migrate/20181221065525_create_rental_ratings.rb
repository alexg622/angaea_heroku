class CreateRentalRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :rental_ratings do |t|
      t.integer :user_id
      t.integer :rental_id
      t.string :stars
      t.text :comment

      t.timestamps
    end
    add_index :rental_ratings, :user_id
    add_index :rental_ratings, :rental_id
  end
end
