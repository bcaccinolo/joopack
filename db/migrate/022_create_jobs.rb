class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.column :title, :string
      t.column :location, :string
      t.column :description, :text
    end
  end

  def self.down
    drop_table :jobs
  end
end
