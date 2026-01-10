class Users::RegistrationsController < Devise::RegistrationsController
  layout :layout

  def index
    @users = User.order('id desc').page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @notices }
    end
  end

  def show
    @users = User.order('id desc').page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @notices }
    end
  end

  # GET /resource/sign_up
  #  def new
  #    resource = build_resource({})
  #    respond_with resource
  #  end

  # POST /resource
  def create
    if Rails.env.production?
      unless verify_turnstile
        flash.now[:alert] = "로봇 차단됨"
        render :new and return
      end
    end

    build_resource(resource_params)

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end

  # The path used after sign up for inactive accounts. You need to overwrite
  # this method in your own RegistrationsController.
  def after_inactive_sign_up_path_for(resource)
    respond_to?(:root_path) ? root_path : "/"
  end

  # The default url to be used after updating a resource. You need to overwrite
  # this method in your own RegistrationsController.
  def after_update_path_for(resource)
    signed_in_root_path(resource)
  end


  def layout
    if params[:no_layout].present?
      return false
    else
      return 'user'
    end
  end

  protected

  def verify_turnstile
    token = params["cf-turnstile-response"]
    return false if token.blank?

    uri = URI("https://challenges.cloudflare.com/turnstile/v0/siteverify")
    response = Net::HTTP.post_form(uri, {
      "secret" => ENV["TURNSTILE_SECRET_KEY"],
      "response" => token,
      "remoteip" => request.remote_ip
    })

    json = JSON.parse(response.body)
    json["success"] == true
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :current_password, :description, :photo, :photo_cache, :description)
  end

  private

  def resource_params
    params.require(:user).permit(:name, :email, :password, :current_password, :description, :photo, :photo_cache, :description)
  end
end
