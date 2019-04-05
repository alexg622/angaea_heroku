class CreateBookingVenues < ActiveRecord::Migration[5.2]
  def change
    create_table :booking_venues do |t|
      t.integer :activity_id
      t.integer :venue_id
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.integer :price

      t.timestamps
    end
    add_index :booking_venues, [:activity_id]
    add_index :booking_venues, [:venue_id]
  end
end
