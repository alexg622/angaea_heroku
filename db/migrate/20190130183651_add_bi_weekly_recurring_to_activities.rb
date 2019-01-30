class AddBiWeeklyRecurringToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :bi_weekly_recurring, :string
  end
end
