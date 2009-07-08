class RemoveExportStatus < ActiveRecord::Migration
  def self.up
    remove_column :users, :export_status
  end

  def self.down
    add_column :users, :export_status, :integer, :default => 0    
  end
end
