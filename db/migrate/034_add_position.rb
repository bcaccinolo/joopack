class AddPosition < ActiveRecord::Migration
  def self.up
    add_column :formations, :position, :integer
    add_column :experiences, :position, :integer
  end

  def self.down
    remove_column :formations, :position
    remove_column :experiences, :position
  end
end
