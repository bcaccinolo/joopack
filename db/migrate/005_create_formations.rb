class CreateFormations < ActiveRecord::Migration
  def self.up
    create_table :formations do |t|
      t.column :diploma, :string
      t.column :school, :string
      t.column :date, :date
      t.column :user_id, :integer
    end
  end

  def self.down
    drop_table :formations
  end
end
