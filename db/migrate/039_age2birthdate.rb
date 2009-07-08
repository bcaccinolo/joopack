class Age2birthdate < ActiveRecord::Migration
  def self.up
    remove_column :moovers_datas, :age
    add_column :moovers_datas, :birthdate, :date
  end

  def self.down
    add_column :moovers_datas, :age, :integer
    remove_column :moovers_datas, :birthdate
  end
end
