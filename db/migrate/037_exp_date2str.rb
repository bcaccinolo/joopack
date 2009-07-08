class ExpDate2str < ActiveRecord::Migration
  def self.up
    remove_column :experiences, :begin
    remove_column :experiences, :end
    add_column :experiences, :begin, :string
    add_column :experiences, :end, :string

  end

  def self.down
  end
end
