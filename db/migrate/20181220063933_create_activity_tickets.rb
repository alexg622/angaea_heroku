class CreateActivityTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_tickets do |t|
      t.integer :user_id
      t.integer :activity_id

      t.timestamps
    end
    add_index :activity_tickets, :user_id
    add_index :activity_tickets, :activity_id
  end
end
