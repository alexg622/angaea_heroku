class CreateUserChatrooms < ActiveRecord::Migration[5.2]
  def change
    create_table :user_chatrooms do |t|
      t.string :title
      
      t.timestamps
    end
  end
end
