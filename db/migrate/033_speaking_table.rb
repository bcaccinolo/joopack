class SpeakingTable < ActiveRecord::Migration
  def self.up
   create_table :speakings do |t|
     t.column :language, :string
     t.column :level, :integer
     t.column :position, :integer
     t.column :user_id , :integer
   end
  end

  def self.down
    drop_table :speakings
  end
end

