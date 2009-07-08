class CreateModyBlogs < ActiveRecord::Migration
  def self.up
    create_table :mody_blogs do |t|
      t.column :content, :string
    end
  end

  def self.down
    drop_table :mody_blogs
  end
end
