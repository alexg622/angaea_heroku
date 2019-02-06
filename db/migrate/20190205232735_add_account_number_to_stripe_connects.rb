class AddAccountNumberToStripeConnects < ActiveRecord::Migration[5.2]
  def change
    add_column :stripe_connects, :account_number, :string
  end
end
