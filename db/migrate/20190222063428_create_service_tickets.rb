class CreateServiceTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :service_tickets do |t|
      t.integer :user_id
      t.integer :service_id
      t.datetime :service_time
      t.string :day
      t.string :time

      
      t.timestamps
    end
    add_index :service_tickets, :user_id
    add_index :service_tickets, :service_id
  end
end
