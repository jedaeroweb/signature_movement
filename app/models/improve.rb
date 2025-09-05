class Improve < ApplicationRecord
  attr_accessor :raw_content

  has_rich_text :content
  validates_presence_of :title, :raw_content
end
