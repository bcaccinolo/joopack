class ConvertionUserIdToCvId < ActiveRecord::Migration
  def self.up
    remove_column :moovers_datas, :user_id
    remove_column :photos, :user_id
    remove_column :experiences, :user_id
    remove_column :formations, :user_id
    remove_column :speakings, :user_id
    remove_column :skills, :user_id
    remove_column :hobbies, :user_id
    remove_column :avatars, :user_id
    remove_column :actions, :user_id

    add_column :moovers_datas, :cv_id, :integer
    add_column :photos, :cv_id, :integer
    add_column :experiences, :cv_id, :integer
    add_column :formations, :cv_id, :integer
    add_column :speakings, :cv_id, :integer
    add_column :skills, :cv_id, :integer
    add_column :hobbies, :cv_id, :integer
    add_column :avatars, :cv_id, :integer
    add_column :actions, :cv_id, :integer
  end

  def self.down
    add_column :moovers_datas, :user_id, :integer
    add_column :photos, :user_id, :integer
    add_column :experiences, :user_id, :integer
    add_column :formations, :user_id, :integer
    add_column :speakings, :user_id, :integer
    add_column :skills, :user_id, :integer
    add_column :hobbies, :user_id, :integer
    add_column :avatars, :user_id, :integer
    add_column :actions, :user_id, :integer

    remove_column :moovers_datas, :cv_id
    remove_column :photos, :cv_id
    remove_column :experiences, :cv_id
    remove_column :formations, :cv_id
    remove_column :speakings, :cv_id
    remove_column :skills, :cv_id
    remove_column :hobbies, :cv_id
    remove_column :avatars, :cv_id
    remove_column :actions, :cv_id
  end
end


