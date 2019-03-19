class CreateReadMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :read_messages do |t|
      t.integer :user_id
      t.integer :message_id

      t.timestamps
    end
    add_index :read_messages, :user_id 
  end
end
