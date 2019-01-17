class AddAccountActivationSecretToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :account_activation_secret, :string
  end
end
