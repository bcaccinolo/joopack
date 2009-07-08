class CreateCivilities < ActiveRecord::Migration
  def self.up
    create_table :civilities do |t|
      t.column :name, :string
      t.column :surname, :string
      t.column :birth_date, :date
      t.column :user_id, :integer
      t.column :city, :string
    end
  end

  def self.down
    drop_table :civilities
  end
end
