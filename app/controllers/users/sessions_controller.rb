class Users::SessionsController < Devise::SessionsController
  layout :layout

  def presign

  end

  def layout
    if params[:no_layout].present?
      return false
    else
      return 'user'
    end
  end
end
