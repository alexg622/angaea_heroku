class RenameUserIdToServiceId < ActiveRecord::Migration[5.2]
  def change
    rename_column :appointments, :user_id, :service_id
  end
end
