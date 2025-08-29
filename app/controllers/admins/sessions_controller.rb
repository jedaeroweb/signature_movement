class Admins::SessionsController < Devise::SessionsController
    layout 'admin/login'

    def after_sign_in_path_for(_resource)
        session['user_return_to'] || admin_path
    end

    def after_sign_out_path_for(_resource_or_scope)
        admin_path
    end
end
