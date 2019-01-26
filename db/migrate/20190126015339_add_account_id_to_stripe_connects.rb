class AddAccountIdToStripeConnects < ActiveRecord::Migration[5.2]
  def change
    add_column :stripe_connects, :accountId, :string
  end
end
