class CreateActions < ActiveRecord::Migration
  def self.up
    create_table :actions do |t|
      t.column :action_type, :string
      t.column :status, :string
      t.column :user_id, :integer
      t.column :date, :datetime
      t.column :code, :string
    end
  end

  def self.down
    drop_table :actions
  end
end
