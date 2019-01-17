class AddSpotsBuyingToActivityTickets < ActiveRecord::Migration[5.2]
  def change
    add_column :activity_tickets, :spots_buying, :integer
  end
end
