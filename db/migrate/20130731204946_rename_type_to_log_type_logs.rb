class RenameTypeToLogTypeLogs < ActiveRecord::Migration
  def change
    rename_column :logs, :type, :log_type
  end
end
