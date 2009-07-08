class CreateCvs < ActiveRecord::Migration
  def self.up
    create_table :cvs do |t|
      t.column :name, :string
      t.column :user_id, :integer
    end
  end

  def self.down
    drop_table :cvs
  end
end
