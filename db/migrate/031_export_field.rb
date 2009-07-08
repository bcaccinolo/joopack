class ExportField < ActiveRecord::Migration
  def self.up
    add_column :users, :export_status, :integer, :default => 0
  end


  def self.down
    remove_column :users, :export_status
  end
end
