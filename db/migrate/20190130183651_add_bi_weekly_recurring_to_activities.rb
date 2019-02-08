class AddBiWeeklyRecurringToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :recurring_schedule, :string
  end
end
