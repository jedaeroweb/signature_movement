class ComplimentCategory < ApplicationRecord
  validates_presence_of :title
  has_many :compliment,:dependent => :destroy
end
