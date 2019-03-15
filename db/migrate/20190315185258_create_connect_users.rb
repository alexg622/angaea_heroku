class CreateConnectUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :connect_users do |t|
      t.integer :user_id
      t.integer :user_chatroom_id
      t.timestamps
    end
    add_index :connect_users, :user_id
    add_index :connect_users, :user_chatroom_id
  end
end
