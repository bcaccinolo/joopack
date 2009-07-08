class CreateSkills < ActiveRecord::Migration
  def self.up
    create_table :skills do |t|
     t.column :title, :string
     t.column :desc, :string
     t.column :position, :integer
     t.column :user_id , :integer     
    end
  end

  def self.down
    drop_table :skills
  end
end



