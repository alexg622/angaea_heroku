class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.integer :user_id
      t.string :client_contact_number
      t.string :client_contact_email
      t.datetime :start_time
      t.datetime :end_time
      t.text :description
      t.string :booked

      t.timestamps
    end
    add_index :appointments, :user_id
  end
end
