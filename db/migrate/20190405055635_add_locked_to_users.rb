class AddLockedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :locked, :string
  end
end
