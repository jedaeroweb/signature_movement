class User < ApplicationRecord
  include OmniauthAttributesConcern
  devise :database_authenticatable, :registerable, :recoverable,  :validatable, :rememberable, :omniauthable, omniauth_providers: [:kakao, :naver, :twitter, :facebook, :apple, :google_oauth2, :github]
  acts_as_voter
  acts_as_votable
  acts_as_commentable
  before_create :default_values
  validates_presence_of :name, :email, :on => :create
  validates_length_of :name, within: 1..60
  validates_length_of :email, within: 4..150
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_uniqueness_of :email
  validates :password,confirmation: true, presence: true, length: { minimum: 6 }, allow_nil: true, allow_blank: true
  has_many :user_authentications, dependent: :destroy
  has_many :user_pictures, dependent: :destroy

  accepts_nested_attributes_for :user_authentications, allow_destroy: true
  accepts_nested_attributes_for :user_pictures, :allow_destroy => true

  def self.create_from_omniauth(params)
    self.__send__(params.provider, params)
  end

  def remember_me
    super || false
  end

  def admin?
    admin
  end

  private

  
  def default_values
    self.name ||= '#'+SecureRandom.uuid
  end
end

