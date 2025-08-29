class Admins::RegistrationsController < Devise::RegistrationsController
    layout 'admin/application'

    def initialize(*params)
        super(*params)

        @category = t(:menu_user)
        @controller_name = t('activerecord.models.admin')
    end

    def admin_layout
        if admin_session
            'admin/application'
        else
            'admin/login'
        end
    end

    def after_update_path_for(resource)
        admin_path(resource)
    end

    # POST /users
    # POST /users.json
    def create
        @admin = Admin.new(admin_params)

        respond_to do |format|
            if @admin.save
                format.html { redirect_to @admin, notice: @controller_name + t(:message_success_insert) }
                format.json { render json: @admin, status: :created, location: @user }
            else
                format.html { render :new }
                format.json { render json: @admin.errors, status: :unprocessable_content }
            end
        end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_admin
        @admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
        params.require(:admin).permit(:login_id, :password, :password_confirmation, :photo, :photo_cache, :remove_photo)
    end
end
