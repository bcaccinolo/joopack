class Cv < ActiveRecord::Base

  belongs_to :user
  has_one :avatar

  has_one  :moovers_data, :dependent => :destroy
  has_one  :photo, :dependent => :destroy
  has_many :experiences, :order => "position ASC", :dependent => :destroy
  has_many :formations, :order => "position ASC", :dependent => :destroy
  has_many :speakings, :order => "position ASC"  , :dependent => :destroy
  has_many :skills, :order => "position ASC" , :dependent => :destroy
  has_many :hobbies, :order => "position ASC" , :dependent => :destroy

  has_one :pdf_export_action, :class_name => "Action", :conditions => "action_type = 'pdf_export'", :dependent => :destroy
  has_one :doc_export_action, :class_name => "Action", :conditions => "action_type = 'doc_export'", :dependent => :destroy
  has_one :odt_export_action, :class_name => "Action", :conditions => "action_type = 'odt_export'", :dependent => :destroy
  has_one :action, :dependent => :destroy

  def get_next_experience_position
    experiences.empty? ? 0 : (experiences.last.position + 1)
  end

  def get_next_formation_position
    formations.empty? ? 0 : (formations.last.position + 1)
  end

  def get_next_speaking_position
    speakings.empty? ? 0 : (speakings.last.position + 1)
  end

  def get_next_skill_position
    skills.empty? ? 0 : (skills.last.position + 1)
  end

  def get_next_hobby_position
    hobbies.empty? ? 0 : (hobbies.last.position + 1)
  end

end
