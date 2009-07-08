class AddCvTitle < ActiveRecord::Migration
  def self.up
    add_column :moovers_datas, :cv_title, :string
  end

  def self.down
    remove_column :moovers_datas, :cv_title
  end
end
