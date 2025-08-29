class Propose < ApplicationRecord
  is_impressionable
  acts_as_commentable
  acts_as_votable
  has_rich_text :content
  validates_presence_of :title
  belongs_to :user, :autosave => true
end
