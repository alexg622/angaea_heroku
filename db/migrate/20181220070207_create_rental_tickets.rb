class CreateRentalTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :rental_tickets do |t|
      t.integer :rental_id
      t.integer :user_id


      t.timestamps
    end
    add_index :rental_tickets, :rental_id
    add_index :rental_tickets, :user_id
  end
end
