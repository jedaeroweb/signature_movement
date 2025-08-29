class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token
  include OmniConcern
  def apple
    create
  end
  def kakao
    create
  end

  def naver
    create
  end

  def facebook
    create
  end

  def github
    create
  end

  def twitter
    create
  end

  def google_oauth2
    create
  end
end
