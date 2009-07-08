class CreateMooversDatas < ActiveRecord::Migration
  def self.up
    create_table :moovers_datas do |t|
      t.column :firstname, :string
      t.column :lastname, :string
      t.column :age, :integer
      t.column :city, :string
      t.column :status, :string
      t.column :post, :string
      t.column :experience_duration, :integer
      t.column :user_id, :integer
    end
  end

  def self.down
    drop_table :moovers_datas
  end
end
