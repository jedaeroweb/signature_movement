module OmniConcern extend ActiveSupport::Concern

def create
  auth_params = request.env["omniauth.auth"]
  provider = AuthenticationProvider.where(:name => auth_params.try(:provider)).first
  authentication = provider.user_authentications.where(uid: auth_params.uid).first
  if authentication.respond_to?(:user_id)
    existing_user = User.where(:id => authentication.user_id).first
    sign_in_with_existing_authentication(existing_user)
  else
    if user_signed_in?
      #SocialAccount.get_provider_account(current_user.id, provider.id).first_or_create(user_id: current_user.id, authentication_provider_id: provider.id, token: auth_params.try(:[], "credentials").try(:[], "token"), secret: auth_params.try(:[], "credentials").try(:[], "secret"))
      redirect_to new_user_registration_url
    elsif authentication
      create_authentication_and_sign_in(auth_params, existing_user, provider)
    else
      create_user_and_authentication_and_sign_in(auth_params, provider)
    end
  end
end

def sign_in_with_existing_authentication(user)
  sign_in_and_redirect(:user, user)
end

def create_authentication_and_sign_in(auth_params, user, provider)
  UserAuthentication.create_from_omniauth(auth_params, user, provider)
  sign_in_and_redirect(:user, user)
end

def create_user_and_authentication_and_sign_in(auth_params, provider)
  user = User.create_from_omniauth(auth_params)
  if user.valid?
    create_authentication_and_sign_in(auth_params, user, provider)
  else
    flash[:error] = user.errors.full_messages.first
    redirect_to new_user_registration_url
  end
end
end
