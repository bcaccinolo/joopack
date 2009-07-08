class Speaking < ActiveRecord::Base
  belongs_to :cv

  before_save :sanitize_strings 
  
  LEVELS = {
    "Courant" => 3,
    "Avancé" => 2,
    "Intermédiaire" => 1,
    "Débutant"  => 0,
  }
  
  INV_LEVELS = LEVELS.invert
  
end
