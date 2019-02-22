class CreateServices < ActiveRecord::Migration[5.2]
  def change
    create_table :services do |t|
      t.text :content, null: false
      t.string :service_name, null: false
      t.string :additional_info
      t.references :user, foreign_key: true
      t.string :cost, null: false
      t.string :addressLN1, null: false
      t.string :addressLN2
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.string :capacity
      t.string :contact_number
      t.string :contact_email
      t.datetime :start_date
      t.datetime :end_date
      t.text :recurring_schedule
      t.string :travel_options
      t.string :availablility_days, null: false
      t.string :availability_hours, null: false 


      t.timestamps
    end
    add_index :services, [:user_id, :created_at]
  end
end
