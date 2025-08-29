class ReportCategory < ApplicationRecord
  validates_presence_of :title
  has_many :report, :dependent => :destroy
end
