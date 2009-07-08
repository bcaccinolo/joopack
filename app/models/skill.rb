class Skill < ActiveRecord::Base
  belongs_to :cv

  before_save :sanitize_strings 


end
