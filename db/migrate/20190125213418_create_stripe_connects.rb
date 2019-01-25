class CreateStripeConnects < ActiveRecord::Migration[5.2]
  def change
    create_table :stripe_connects do |t|
      t.integer :user_id
      t.integer :account_id
      t.string :external_account
      t.string :city
      t.string :address_line1
      t.string :postal_code
      t.string :state
      t.string :dob_day
      t.string :dob_month
      t.string :dob_year
      t.string :first_name
      t.string :last_name
      t.string :ssn_last_4
      t.string :legal_entity_type
      t.datetime :acceptance_date
      t.string :acceptance_ip
      t.string :personal_id_number
      t.string :verification_document

      t.timestamps
    end
    add_index :stripe_connects, :user_id

  end
end
