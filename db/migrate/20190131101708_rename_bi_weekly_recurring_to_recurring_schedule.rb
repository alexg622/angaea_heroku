class RenameBiWeeklyRecurringToRecurringSchedule < ActiveRecord::Migration[5.2]
  def change
    rename_column :activities, :bi_weekly_recurring, :recurring_schedule
  end
end
