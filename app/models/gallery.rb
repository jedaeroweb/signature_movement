class Gallery < ApplicationRecord
  validates_presence_of :title, :photo
  belongs_to :gallery_category
  mount_uploader :photo, GalleryPhotoUploader
end
