class Users::SessionsController < Devise::SessionsController
  def after_sign_in_path_for(resource)
    # admin 로그인 form에서 로그인했는지 확인
    if params[:admin_login].present? && resource.admin?
      admin_root_path
    else
      root_path
    end
  end

  # 로그인 실패 시 실행될 액션
  def failure
    if params[:admin_login].present?
      redirect_to new_admin_session_path, alert: "로그인 실패했습니다. 다시 시도해주세요."
    else
      redirect_to new_user_session_path, alert: "로그인 실패했습니다. 다시 시도해주세요."
    end
  end

  protected

  # auth_options 를 오버라이드해서 실패 시 failure 액션 호출하도록 지정
  def auth_options
    { scope: resource_name, recall: "#{controller_path}#failure" }
  end
end