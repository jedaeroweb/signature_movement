class GalleryCategory < ApplicationRecord
  validates_presence_of :title
  has_many :gallery, :dependent => :destroy
end
