module OmniauthAttributesConcern extend ActiveSupport::Concern
module ClassMethods

  def naver params
    (params['info']['email'] = "dummy#{SecureRandom.hex(10)}@dummy.com") if params['info']['email'].blank?
    attributes = {
      email: params['info']['email'],
      name: params['info']['name'],
      password: Devise.friendly_token,
    }
    create(attributes)
  end

  def kakao params
    (params['info']['email'] = "dummy#{SecureRandom.hex(10)}@dummy.com") if params['info']['email'].blank?
    attributes = {
      email: params['info']['email'],
      name: params['info']['name'],
      password: Devise.friendly_token,
    }
    create(attributes)
  end

  def facebook params
    (params['info']['email'] = "dummy#{SecureRandom.hex(10)}@dummy.com") if params['info']['email'].blank?
    attributes = {
      email: params['info']['email'],
      name: params['info']['name'],
      password: Devise.friendly_token,
    }
    create(attributes)
  end

  def twitter params
    (params['info']['email'] = "dummy#{SecureRandom.hex(10)}@dummy.com") if params['info']['email'].blank?
    attributes = {
      email: params['info']['email'],
      name: params['info']['name'],
      password: Devise.friendly_token,
    }
    create(attributes)
  end

  def github params
    (params['info']['email'] = "dummy#{SecureRandom.hex(10)}@dummy.com") if params['info']['email'].blank?
    attributes = {
      email: params['info']['email'],
      name: params['info']['name'],
      password: Devise.friendly_token,
    }
    create(attributes)
  end

  def google_oauth2 params
    (params['info']['email'] = "dummy#{SecureRandom.hex(10)}@dummy.com") if params['info']['email'].blank?
    attributes = {
      email: params['info']['email'],
      name: params['info']['name'],
      password: Devise.friendly_token,
    }
    create(attributes)
  end

  def apple params
    (params['info']['email'] = "dummy#{SecureRandom.hex(10)}@dummy.com") if params['info']['email'].blank?
    attributes = {
      email: params['info']['email'],
      name: params['info']['name'],
      password: Devise.friendly_token,
    }
    create(attributes)
  end
end
end
