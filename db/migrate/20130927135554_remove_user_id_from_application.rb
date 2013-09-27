class RemoveUserIdFromApplication < ActiveRecord::Migration
  def change
    remove_column :applications, :user_id
  end


end
