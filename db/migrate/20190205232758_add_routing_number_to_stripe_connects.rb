class AddRoutingNumberToStripeConnects < ActiveRecord::Migration[5.2]
  def change
    add_column :stripe_connects, :routing_number, :string
  end
end
