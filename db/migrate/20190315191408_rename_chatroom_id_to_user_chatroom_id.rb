class RenameChatroomIdToUserChatroomId < ActiveRecord::Migration[5.2]
  def change
    rename_column :user_messages, :chatroom_id, :user_chatroom_id
  end
end
