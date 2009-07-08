class Feedback < ActiveRecord::Migration
  def self.up
    create_table :feedbacks do |t|
      t.column :title, :string
      t.column :content, :text
      t.column :user_id, :integer
      t.column :created_at, :datetime
    end
  end

  def self.down
    drop_table :feedbacks
  end


end
