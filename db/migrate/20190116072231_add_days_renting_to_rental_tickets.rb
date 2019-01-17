class AddDaysRentingToRentalTickets < ActiveRecord::Migration[5.2]
  def change
    add_column :rental_tickets, :days_renting, :integer
  end
end
