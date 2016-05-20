class Diary < ActiveRecord::Base

  has_attached_file :photo, :style => {:medium => '300x300', :thumb =>'100x100'}, 
    :url => "/attachment/:id/photo/:style/:basename.:extension",
    :path => ":rails_root/public/attachment/:id/photo/:style/:basename.:extension"
 # validates_attachment :photo, :content_type => ['image/jpg', 'image/gif', 'image/png'], :less_than => 10.megabytes
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/  

  has_attached_file :sound,
    :url => '/attachment/:id/sound/:basename.:extension',
    :path => ':rails_root/public/attachment/:id/sound/:basename.:extension'
  validates_attachment_content_type :sound, :content_type => ['application/amr','application/wav'],:less_than => 10.megabytes
end
