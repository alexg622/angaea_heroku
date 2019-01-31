class RenameBiWeeklyRecurringToRecurringSchedule < ActiveRecord::Migration[5.2]
  def change
    rename_column :activities, :recurring_schedule, :recurring_schedule
  end
end
