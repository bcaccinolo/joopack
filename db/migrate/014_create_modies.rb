class CreateModies < ActiveRecord::Migration
  def self.up
    create_table :modies do |t|
      t.column :user_id, :integer
      t.column :position, :integer
      t.column :is_a, :string
      t.column :mody_id, :integer
    end
  end

  def self.down
    drop_table :modies
  end
end
