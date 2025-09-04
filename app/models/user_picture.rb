class UserPicture < ApplicationRecord
  belongs_to :user, autosave: true, counter_cache: true
  mount_uploader :picture, UserPictureUploader
end
