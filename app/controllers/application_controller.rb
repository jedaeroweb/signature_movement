class ApplicationController < ActionController::Base
  layout :layout

  before_action :normalize_seo_query_params
  before_action :before_init
  helper_method :default_meta_tags, :seo_noindex?
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def before_init
    @aside_blog_categories = BlogCategory.where(enable: true)
    @tags = Blog.tag_counts_on(:tags, limit: 20, order: "taggings_count desc")
  end

  def default_meta_tags
    meta_title       = @title.presence || t(:default_title)
    meta_description = @meta_description.presence || t(:meta_description)
    meta_image       = @meta_image.presence || t(:meta_image)
    canonical        = @meta_url.presence || canonical_url_for_current_page
    og_title         = @og_title.presence || meta_title
    og_type          = @meta_type.presence || 'website'

    {
      site: t(:application_name),
      title: meta_title,
      description: meta_description,
      separator: t(:title_separator),
      reverse: true,
      canonical: canonical,
      noindex: seo_noindex?,
      follow: true,
      viewport: 'width=device-width, initial-scale=1',
      og: {
        title: og_title,
        description: meta_description,
        url: canonical,
        image: meta_image,
        type: og_type,
        site_name: t(:application_name),
        locale: I18n.locale.to_s
      },
      twitter: {
        card: 'summary_large_image',
        title: og_title,
        description: meta_description,
        image: meta_image
      }
    }
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

  # 기본 locale 제거 + page=1 제거
  # 예:
  # /products?locale=ko&page=2 -> /products?page=2
  # /products?page=1&locale=en -> /products?locale=en
  def normalize_seo_query_params
    clean = request.query_parameters.deep_dup
    changed = false

    # 기본 locale 제거
    #    if clean["locale"].to_s == I18n.default_locale.to_s
    #  clean.delete("locale")
    #  changed = true
    #end

    # page=1 제거
    if clean["page"].to_s == "1"
      clean.delete("page")
      changed = true
    end

    return unless changed

    uri = URI.parse(request.path)
    uri.query = clean.to_query.presence

    redirect_to uri.to_s, status: :moved_permanently
  end

  # 공통 noindex 규칙
  # 필요하면 각 컨트롤러에서 override 가능
  def seo_noindex?
    return true if params[:no_layout].present?
    return true if params[:sort].present?
    return true if params[:q].present?

    return true if controller_name == "tags"

    filter_keys = %w[list_type locale tag tags search_type search keyword order blog_category_id per view tab page utf8]

    (params.keys.map(&:to_s) & filter_keys).any?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :remember_me, user_pictures_attributes: [:id, :picture, :_destroy]).except(:roles_admin__attributes) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:email, :password, :password_confirmation, :current_password, user_pictures_attributes: [:id, :picture, :_destroy]) }
  end

  def admin_signed_in?
    user_signed_in? && current_user.admin?
  end

  def current_admin
    @current_admin ||= current_user if user_signed_in? && current_user.admin?
  end

  def authenticate_admin!(opts = {})
    unless current_admin
      redirect_to new_admin_session_path, alert: "관리자 로그인이 필요합니다."
    end
  end

  helper_method :admin_signed_in?, :current_admin
end
