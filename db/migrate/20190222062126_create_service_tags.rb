class CreateServiceTags < ActiveRecord::Migration[5.2]
  def change
    create_table :service_tags do |t|
      t.integer :service_id
      t.integer :category_id

      t.timestamps
    end
    add_index :service_tags, :service_id
    add_index :service_tags, :category_id 
  end
end
