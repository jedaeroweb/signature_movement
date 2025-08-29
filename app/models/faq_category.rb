class FaqCategory < ApplicationRecord
  validates_presence_of :title
  has_many :faq, :dependent => :destroy
end
