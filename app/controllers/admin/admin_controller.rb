class Admin::AdminController < ApplicationController
    before_action :authenticate_admin!
    load_and_authorize_resource

    def resource_name
        :admin
    end

    def resource
        @resource ||= Admin.new
    end

    def devise_mapping
        @devise_mapping ||= Devise.mappings[:admin]
    end

    rescue_from CanCan::AccessDenied do |_exception|
        if current_user
            if current_user.admin?
                render file: "#{Rails.root}/public/403.html", status: 403, layout: false
            else
                redirect_to root_path
            end
        else
            redirect_to new_admin_session_path
        end
    end

    def layout
        if params[:no_layout]
            false
        else
            if params[:popup]
                'admin/popup'
            else
                'admin/application'
            end
        end
    end

end
