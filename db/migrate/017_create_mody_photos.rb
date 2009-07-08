class CreateModyPhotos < ActiveRecord::Migration
  def self.up
    create_table :mody_photos do |t|
    end
  end

  def self.down
    drop_table :mody_photos
  end
end
