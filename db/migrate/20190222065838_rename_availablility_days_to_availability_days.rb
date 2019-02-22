class RenameAvailablilityDaysToAvailabilityDays < ActiveRecord::Migration[5.2]
  def change
    rename_column :services, :availablility_days, :availability_days
  end
end
