class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.string :digits, null: false
      t.string :exp_date, null: false
      t.string :cvv, null: false
      t.string :bill_zipcode, null: false
      t.integer :user_id

      t.timestamps
    end
    add_index :cards, :user_id
  end
end
