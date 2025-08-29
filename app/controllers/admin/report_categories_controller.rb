class Admin::ReportCategoriesController < Admin::AdminController
  before_action :set_admin_report_category, only: [:show, :edit, :update, :destroy]

  def initialize(*params)
    super(*params)

    @category = t(:menu_main_board,scope:[:admin_menu])
    @controller_name = t('activerecord.models.report_category')
  end

  # GET /admin/report_categories
  # GET /admin/report_categories.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    @admin_report_categories = ReportCategory.order('id desc').page(params[:page]).per(params[:per_page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @admin_report_categories }
    end
  end

  # GET /admin/report_categories/1
  # GET /admin/report_categories/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @admin_report_category }
    end
  end

  # GET /admin/report_categories/new
  # GET /admin/report_categories/new.json
  def new
    @admin_report_category = ReportCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @admin_report_category }
    end
  end

  # GET /admin/report_categories/1/edit
  def edit
  end

  # POST /admin/report_categories
  # POST /admin/report_categories.json
  def create
    @admin_report_category = ReportCategory.new(admin_report_category_params)

    respond_to do |format|
      if @admin_report_category.save
        format.html { redirect_to admin_report_category_path(@admin_report_category), notice: @controller_name +t(:message_success_create)}
        format.json { render :json => @admin_report_category, :status => :created, :location => @admin_report_category }
      else
        format.html { render :action => "new" }
        format.json { render :json => @admin_report_category.errors, :status => :unprocessable_content }
      end
    end
  end

  # PUT /admin/report_categories/1
  # PUT /admin/report_categories/1.json
  def update
    respond_to do |format|
      if @admin_report_category.update(admin_report_category_params)
        format.html { redirect_to admin_report_category_path(@admin_report_category), notice: @controller_name +t(:message_success_update)}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @admin_report_category.errors, :status => :unprocessable_content }
      end
    end
  end

  # DELETE /admin/report_categories/1
  # DELETE /admin/report_categories/1.json
  def destroy
    @admin_report_category.destroy

    respond_to do |format|
      format.html { redirect_to admin_report_categories_path}
      format.json { head :ok }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_report_category
    @admin_report_category = ReportCategory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_report_category_params
    params.require(:report_category).permit(:report_category_id,:title,:enable)
  end
end
