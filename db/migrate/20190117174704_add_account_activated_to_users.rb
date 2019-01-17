class AddAccountActivatedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :account_activated, :string
  end
end
