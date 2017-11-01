class Post < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  belongs_to :user
  
  validates :image, presence: true
  validates :content, presence: true
end 
