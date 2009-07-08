class AddStarOnTags < ActiveRecord::Migration
  def self.up
    add_column :taggings, :star, :boolean, :default => false
  end

  def self.down
    remove_column :taggings, :star
  end
end
