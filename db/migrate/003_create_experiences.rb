class CreateExperiences < ActiveRecord::Migration
  def self.up
    create_table :experiences do |t|
      t.column :user_id, :integer
      t.column :company, :string
      t.column :function, :string
      t.column :begin, :date
      t.column :end, :date
    end
  end

  def self.down
    drop_table :experiences
  end
end
