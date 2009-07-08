class CreateModyVideos < ActiveRecord::Migration
  def self.up
    create_table :mody_videos do |t|
      t.column :title, :string
      t.column :url, :string
      t.column :object, :text
      t.column :comment, :text
    end
  end

  def self.down
    drop_table :mody_videos
  end
end
