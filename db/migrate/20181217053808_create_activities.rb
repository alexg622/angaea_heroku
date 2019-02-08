class CreateActivities < ActiveRecord::Migration[5.2]
 def change
   create_table :activities do |t|
     #generate name

     t.text :content, null: false
     t.string :activity_name, null: false
     t.string :additional_info
     t.references :user, foreign_key: true
     t.string :cost, null: false
     t.string :addressLN1, null: false
     t.string :addressLN2
     t.string :city, null: false
     t.string :state, null: false
     t.string :zip, null: false
     t.string :picture
     t.string :capacity, null: false
     t.string :contact_number
     t.string :contact_email, null: false
     t.string :bi_weekly_recurring
     t.string :weekly_recurring
     t.string :recurring_schedule
     t.datetime :start_date, null: false
     t.datetime :end_date, null: false


     t.timestamps
   end
   add_index :activities, [:user_id, :created_at]
 end
end
