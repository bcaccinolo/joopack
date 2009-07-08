class AddPostalCode < ActiveRecord::Migration
  def self.up
    add_column :moovers_datas, :postal_code, :string
  end

  def self.down
    remove_column :moovers_datas, :postal_code
  end
end
