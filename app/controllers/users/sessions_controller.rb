class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    # admin 로그인 form에서 로그인했는지 확인
    if params[:admin_login].present? && resource.admin?
      admin_root_path
    else
      root_path
    end
  end
end
