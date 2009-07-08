class CreateModyTexts < ActiveRecord::Migration
  def self.up
    create_table :mody_texts do |t|
      t.column :title, :string
      t.column :content, :text
    end
  end

  def self.down
    drop_table :mody_texts
  end
end
