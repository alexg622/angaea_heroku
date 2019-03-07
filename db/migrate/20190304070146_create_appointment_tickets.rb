class CreateAppointmentTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :appointment_tickets do |t|
      t.integer :user_id
      t.integer :appointment_id
      t.timestamps
    end
    add_index :appointment_tickets, [:user_id, :appointment_id]
  end
end
