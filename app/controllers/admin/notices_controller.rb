class Admin::NoticesController < Admin::AdminController
  before_action :set_admin_notice, only: [:show, :edit, :update, :destroy]

  def initialize(*params)
    super(*params)

    @category = t(:menu_etc_board,scope:[:admin_menu])
    @controller_name = t('activerecord.models.notice')
  end

  # GET /admin/notices
  # GET /admin/notices.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    @admin_notices = Notice.order('id desc').page(params[:page]).per(params[:per_page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_notices }
    end
  end

  # GET /admin/notices/1
  # GET /admin/notices/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_notice }
    end
  end

  # GET /admin/notices/new
  # GET /admin/notices/new.json
  def new
    @admin_notice = Notice.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_notice }
    end
  end

  # GET /admin/notices/1/edit
  def edit
  end

  # POST /admin/notices
  # POST /admin/notices.json
  def create
    @admin_notice = Notice.new(admin_notice_params)

    respond_to do |format|
      if @admin_notice.save
        format.html { redirect_to admin_notice_path(@admin_notice), :notice=> @controller_name +t(:message_success_create)}
        format.json { render json: @admin_notice, status: :created, location: @admin_notice }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_notice.errors, status: :unprocessable_content }
      end
    end
  end

  # PUT /admin/notices/1
  # PUT /admin/notices/1.json
  def update
    respond_to do |format|
      if @admin_notice.update(admin_notice_params)
        format.html { redirect_to admin_notice_path(@admin_notice), :notice=> @controller_name +t(:message_success_update)}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_notice.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /admin/notices/1
  # DELETE /admin/notices/1.json
  def destroy
    @admin_notice.destroy

    respond_to do |format|
      format.html { redirect_to admin_notices_path}
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_notice
    @admin_notice = Notice.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_notice_params
    params.require(:notice).permit(:id, :title, :content, :enable).merge(user_id: current_admin.id)
  end
end
