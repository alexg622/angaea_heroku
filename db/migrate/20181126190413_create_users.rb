class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :profession
      t.text :skills
      t.text :about 
      t.boolean :agree_to_terms
      t.boolean :agree_to_privacy


      t.timestamps
    end
  end
end
