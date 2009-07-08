class AddNewsletterToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :newsletters, :boolean, {:default => true }
  end

  def self.down
    remove_column :users, :newsletters
  end
end
