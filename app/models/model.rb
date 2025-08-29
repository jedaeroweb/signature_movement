class Model < ApplicationRecord
  is_impressionable
  acts_as_commentable
  acts_as_votable
  has_rich_text :content
  validates_presence_of :title, :description
  belongs_to :user, :autosave => true
  mount_uploader :photo, ModelPhotoUploader
end
