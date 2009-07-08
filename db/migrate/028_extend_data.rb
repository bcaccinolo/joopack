class ExtendData < ActiveRecord::Migration
  def self.up
    add_column :moovers_datas, :address, :string
    add_column :moovers_datas, :email, :string
    add_column :moovers_datas, :phone, :string
    remove_column :moovers_datas, :experience_duration
  end

  def self.down
    remove_column :moovers_datas, :address
    remove_column :moovers_datas, :email
    remove_column :moovers_datas, :phone
    add_column :moovers_datas, :experience_duration, :integer
  end
end
