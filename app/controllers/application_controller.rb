class ApplicationController < ActionController::Base
  layout :layout
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def initialize(*params)
    super(*params)

    @application_name=t(:application_name)
    @controller_name=t(:application_name)
    @title=t(:default_title)

    @meta_robot='all, index, follow'
    @meta_description=t(:meta_description)
    @meta_keywords=t(:meta_keywords)
    @meta_image=t(:meta_image)

    @page_itemtype="http://schema.org/WebPage"
    @resource ||= User.new
  end

  def current_ability
    @current_ability ||= UserAbility.new(current_user)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_user_session_path, :notice => t(:unauthenticated,scope:[:devise,:failure])
  end

  def set_locale
    I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale

    @language={t(:korean)=>'ko',t(:english)=>'en',t(:chineses)=>'zh-CN'}
  end

  def layout
    if params[:no_layout]
      false
    else
      if params[:popup]
        'popup'
      else
        'application'
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password,
                                                               :password_confirmation, :remember_me, :photo, :photo_cache, :remove_photo).except(:roles_admin__attributes) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password,
                                                                      :password_confirmation, :current_password, :photo, :photo_cache, :remove_photor) }
  end
end
