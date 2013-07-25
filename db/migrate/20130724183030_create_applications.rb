class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.integer :user_id
      t.string :api_key
      t.timestamps
    end
    add_index :applications, :user_id
  end
end
