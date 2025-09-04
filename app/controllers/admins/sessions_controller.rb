class Admins::SessionsController < Devise::SessionsController
    layout 'admin/login'

    protected

    # 로그인 성공 후 이동할 경로
    def after_sign_in_path_for(resource)
        admin_root_path   # /admin 로 이동
    end

    # 로그아웃 후 이동할 경로
    def after_sign_out_path_for(resource_or_scope)
        new_admin_session_path  # /admins/login
    end
end
