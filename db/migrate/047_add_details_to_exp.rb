class AddDetailsToExp < ActiveRecord::Migration
  def self.up
    add_column :experiences, :details, :text
  end

  def self.down
    remove_column :experiences, :details
  end
end
