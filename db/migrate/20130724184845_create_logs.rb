class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :application_id
      t.string :type
      t.text :message
      t.timestamps
    end
    add_index :logs, :application_id
  end
end
