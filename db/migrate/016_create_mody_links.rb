class CreateModyLinks < ActiveRecord::Migration
  def self.up
    create_table :mody_links do |t|
    end
  end

  def self.down
    drop_table :mody_links
  end
end
