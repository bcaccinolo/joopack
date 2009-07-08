class Avatar < ActiveRecord::Base
  belongs_to :cv

  acts_as_attachment :content_type => :image, :storage => :file_system, :file_system_path => 'public/images/avatars', :resize_to => '110'
end
