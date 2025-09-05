class Admin::ReportsController < Admin::AdminController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  # GET /admin/reports
  # GET /admin/reports.json
  def index
    @admin_reports = Report.order('id desc').page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_reports }
    end
  end

  # GET /admin/reports/1
  # GET /admin/reports/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_report }
    end
  end

  # GET /admin/reports/new
  # GET /admin/reports/new.json
  def new
    @admin_report = Report.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_report }
    end
  end

  # GET /admin/reports/1/edit
  def edit
  end

  # POST /admin/reports
  # POST /admin/reports.json
  def create
    @admin_report = Report.new(report_params)

    respond_to do |format|
      if @admin_report.save
        format.html { redirect_to admin_reports_url, notice: t(:report, scope: [:activerecord, :ad_models]) + t(:message_success_create) }
        format.json { render json: @admin_report, status: :created, location: @admin_report }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_report.errors, status: :unprocessable_content }
      end
    end
  end

  # PUT /admin/reports/1
  # PUT /admin/reports/1.json
  def update
    respond_to do |format|
      if @admin_report.update(report_params)
        format.html { redirect_to admin_reports_url, notice: t(:report, scope: [:activerecord, :ad_models]) + t(:message_success_update) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_report.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /admin/reports/1
  # DELETE /admin/reports/1.json
  def destroy
    @admin_report.destroy

    respond_to do |format|
      format.html { redirect_to admin_reports_path}
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_report
    @admin_report = Report.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def report_params
    params.require(:report).permit(:report_category_id, :title, :content).merge(user_id: current_user.id)
  end
end
