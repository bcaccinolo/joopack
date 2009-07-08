class FormationDate2str < ActiveRecord::Migration
  def self.up
    remove_column :formations, :date
    add_column :formations, :date, :string
  end

  def self.down
  end
end
