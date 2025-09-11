class Admins::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_admin!
  layout 'admin/login'
  # GET /admins
  # GET /admins.json
  def index
  end

  def new
  end

  def edit
  end

  # POST /users
  # POST /users.json
  def create
  end
end