class CreateUserMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :user_messages do |t|
      t.string :content
      t.integer :user_id
      t.integer :chatroom_id
      t.string :read

      t.timestamps
    end
    add_index :user_messages, :user_id 
    add_index :user_messages, :chatroom_id
  end
end
