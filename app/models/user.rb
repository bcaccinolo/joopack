require 'digest/sha1'
class User < ActiveRecord::Base
  
  before_create :make_activation_code
  attr_protected :activated_at

  # Virtual attribute for the unencrypted password
  attr_accessor :password

  has_many :cvs
 
  validates_presence_of :login, :message => '^Login ne peut être vide'
  validates_length_of   :login, :within => 3..40
  validates_uniqueness_of   :login, :case_sensitive => false, :message => '^Login déja pris'

  validates_presence_of :email, :message => '^Email ne peut être vide'
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of  :email, :case_sensitive => false, :message => '^Email déja pris'

  validates_presence_of     :password, :message => '^Mot de passe ne peut être vide', :if => :password_required?
  validates_presence_of     :password_confirmation, :message => '^La confirmation du mot de passe ne peut être vide', :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?, :message => 'apa is spelled with %d characters.'
  validates_confirmation_of :password,                   :if => :password_required?
  
  before_save :encrypt_password

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    # hide records with a nil activated_at
    # u = find :first, :conditions => ['login = ? and activated_at IS NOT NULL', login]
    u = find :first, :conditions => ['login = ?', login]
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Activates the user in the database.
  def activate
    @activated = true
    update_attribute(:activation_code, nil)
    update_attribute(:activated_at, Time.now)
  end

  # Returns true if the user has just been activated.
  def recently_activated?
    @activated
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    self.remember_token_expires_at = 2.weeks.from_now.utc
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

  # Usefull method to implement the "Password forgotten" functionality 
  def gen_new_password
    self.password = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--").slice(0,6)
    self.password_confirmation = self.password
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--")
    self.crypted_password = encrypt(self.password)
    self.save
  end


protected
  # before filter 
  def encrypt_password
    return if password.blank?
    self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
    self.crypted_password = encrypt(password)
  end
  
  def password_required?
    crypted_password.blank? || !password.blank?
  end
  
  # If you're going to use activation, uncomment this too
  def make_activation_code
    self.activation_code = Digest::SHA1.hexdigest( Time.now.to_s.split(//).sort_by {rand}.join )
  end
      
end
