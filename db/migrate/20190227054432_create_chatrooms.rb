class CreateChatrooms < ActiveRecord::Migration[5.2]
  def change
    create_table :chatrooms do |t|
      t.integer :activity_id
      t.string :topic
      t.string :slug

      t.timestamps
    end
    add_index :chatrooms, :activity_id
  end
end
