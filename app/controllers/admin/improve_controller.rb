class Admin::ImproveController < Admin::AdminController
  before_action :set_admin_improve, only: [:show, :edit, :update, :destroy]

  def initialize(*params)
    super(*params)

    @category = t(:menu_etc_board,scope:[:admin_menu])
    @controller_name = t('activerecord.models.improve')
  end

  # GET /admin/improve
  # GET /admin/improve.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    @admin_improves = Improve.order('id desc').page(params[:page]).per(params[:per_page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_improves }
    end
  end

  # GET /admin/improve/1
  # GET /admin/improve/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_improve }
    end
  end

  # GET /admin/improve/new
  # GET /admin/improve/new.json
  def new
    @admin_improve = Improve.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_improve }
    end
  end

  # GET /admin/improve/1/edit
  def edit
  end

  # POST /admin/improve
  # POST /admin/improve.json
  def create
    @admin_improve = Improve.new(admin_improve_params)

    respond_to do |format|
      if @admin_improve.save
        format.html { redirect_to admin_improve_path(@admin_improve), notice: @controller_name + t(:message_success_create) }
        format.json { render json: @admin_improve, status: :created, location: @admin_improve }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_improve.errors, status: :unprocessable_content }
      end
    end
  end

  # PUT /admin/improve/1
  # PUT /admin/improve/1.json
  def update
    respond_to do |format|
      if @admin_improve.update(admin_improve_params)
        format.html { redirect_to admin_improve_path(@admin_improve), notice: @controller_name + t(:message_success_update) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_improve.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /admin/improve/1
  # DELETE /admin/improve/1.json
  def destroy
    @admin_improve.destroy

    respond_to do |format|
      format.html { redirect_to admin_improves_path}
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_improve
    @admin_improve = Improve.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_improve_params
    params.require(:improve).permit(:title, :content, :enable)
  end
end
