class UsersController < ApplicationController
  load_and_authorize_resource  except: [:index, :show, :create, :new_comment]
  before_action :set_user, only: [:edit, :sign, :update, :destroy, :upvote, :downvote, :create_comment, :new_comment, :delete_confirm]

  def initialize(*params)
    super(*params)

    @category=t(:menu_user)
    @sub_menu=t(:submenu_user)
    @controller_name=t('activerecord.models.user')
    @script='application'
  end

  def user_id_select
    @script='users/user_id_select'
  end

  def user_id_select_search_result
    case params[:find_method]
      when 'login_id'
        condition_sql='username like ?'
      when 'email'
        condition_sql='email like ?'
      when 'user_id'
        condition_sql='id like ?'
      when 'market'
        condition_sql='market like ?'
    end

    unless params[:per_page].present?
      params[:per_page]=20
    end

    @user_count = User.order('id desc').where(condition_sql,'%'+params[:search].strip+'%').count
    @users = User.order('id desc').where(condition_sql,'%'+params[:search].strip+'%').page(params[:page]).per(params[:per_page])

    @script='users/user_id_select'

    if(@user_count.zero?)
      a={:count=>@user_count}
    else
      a={:count=>@user_count,:list=>@users}
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => a }
    end
  end

  def new_comment

  end

  def create_comment
    @user.comments << Comment.new(comment_params)

    respond_to do |format|
      format.html { redirect_to user_path(@user)}
      format.json { render :json => @users }
    end
  end

  # GET /users
  # GET /users.json
  def index
    if params[:login_id].present? || params[:cell_phone].present?
      likesql='1=1'
      likep=[]
    end

    unless params[:per_page].present?
      params[:per_page]=10
    end

    conditions={}
    conditions[:user_id]=params[:user_id] if params[:user_id].present?
    conditions[:flag]=params[:flag] if params[:flag].present?


    @users = User.where('1=1')

    if params[:cell_phone].present?
      @users = @users.where('mobile_num like ?', params[:cell_phone].strip+'%')
    end
    if params[:login_id].present?
      @users = @users.where('username like ?', '%'+params[:login_id].strip+'%')
    end
    if params[:market].present?
      @users = @users.where('market like ?', params[:market].strip)
    end
    if params[:start_date].present? and params[:date_p] != 'false'
      @users = @users.where(:created_at => (change_date(params[:start_date],false))..(change_date(params[:end_date])))
    end
    @users = @users.order('id desc').page(params[:page]).per(params[:per_page])

    @user_count=User.count


    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user= User.find(params[:id])

    @title=@user.name
    @comment  = Comment.build_from(@user, current_user, "")

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @comments}
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
  end

  # GET /users/1/edit
  def edit
      if @user.id!=current_user.id
        redirect_to @user, :alert=> "권한이 없습니다."
      end
  end

  def sign
    if @user.id!=current_user.id
      redirect_to @user, :alert=> "권한이 없습니다."
    end
  end

  # POST /users
  # POST /users.json
  def create
    respond_to do |format|
      if @user.save
        format.html { redirect_to user_path(@user), :notice => @controller_name +t(:message_success_create)}
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_content }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update

    puts @user
    puts user_params

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(@user), :notice => @controller_name +t(:message_success_update)}
        format.json { head :no_content }
      else
        format.html { render :action => "sign" }
        format.json { render :json => @user.errors, :status => :unprocessable_content }
      end
    end
  end

  def delete_confirm
  end



  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html {}
      format.json { head :no_content }
    end
  end

  def upvote
    respond_to do |format|
      if @user.liked_by current_user
        format.html { redirect_to user_path(@user), :notice => t(:message_success_recommend)}
        format.json { render :json => {vote_up: @user.cached_votes_up}}
      else
        format.html { render :action => "index" }
        format.json { render :json => @user.errors, :status => :unprocessable_content }
      end
    end
  end

  def downvote
    respond_to do |format|
      if @user.downvote_from current_user
        format.html { redirect_to user_path(@user), :notice => t(:message_success_recommend)}
        format.json { render :json => @user.cached_votes_down }
      else
        format.html { render :action => "index" }
        format.json { render :json => @user.errors, :status => :unprocessable_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(current_user.id)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :current_password, :photo, :description )
  end

  def comment_params
    params.require(:comment).permit(:comment).merge(user_id: current_user)
  end
end
