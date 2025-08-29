class AdminPicture < ApplicationRecord
  belongs_to :admin, autosave: true
  mount_uploader :picture, AdminPictureUploader
end
