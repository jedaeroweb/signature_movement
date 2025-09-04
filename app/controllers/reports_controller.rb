class ReportsController < ApplicationController
  load_and_authorize_resource  except: [:index, :show, :create]
  impressionist :actions=>[:show]
  before_action :set_report, only: [:show, :edit, :update, :destroy, :upvote, :downvote]

  def initialize(*params)
    super(*params)
    @controller_name=t('activerecord.models.report')
    @title=@controller_name
  end

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.order('id desc').page(params[:page]).per(10)

    respond_to do |format|
      format.html { render layout: layout } # index.html.erb
      format.json { render json: @reports }
    end
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    @title=@report.title
    @meta_description=@report.content.to_s
    @comment  = Comment.build_from(@report, current_user, "")
  end

  # GET /reports/new
  # GET /reports/new.json
  def new
    @report = Report.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @report }
    end
  end

  # GET /reports/1/edit
  def edit
      if @report.user_id!=current_user.id
        redirect_to @report, :alert=> "권한이 없습니다."
      end
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, :notice=> @controller_name +t(:message_success_create)}
        format.json { render json: @report, status: :created, location: @report }
      else
        format.html { render action: "new" }
        format.json { render json: @report.errors, status: :unprocessable_content }
      end
    end
  end

  # PUT /reports/1
  # PUT /reports/1.json
  def update
    respond_to do |format|
      if @report.update(report_params)
        format.html { redirect_to @report, :notice=> @controller_name +t(:message_success_update)}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @report.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url }
      format.json { head :no_content }
    end
  end

  def upvote
    respond_to do |format|
      if @report.liked_by current_user
        format.html { redirect_to report_path(@report), :notice => t(:message_success_recommend)}
        format.json { render :json => {vote_up: @report.cached_votes_up}}
      else
        format.html { render :action => "index" }
        format.json { render :json => @report.errors, :status => :unprocessable_content }
      end
    end
  end

  def downvote
    respond_to do |format|
      if @report.downvote_from current_user
        format.html { redirect_to report_path(@report), :notice => t(:message_success_recommend)}
        format.json { render :json => {vote_up: @report.cached_votes_down}}
      else
        format.html { render :action => "index" }
        format.json { render :json => @report.errors, :status => :unprocessable_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      params.require(:report).permit(:report_category_id, :title, :content).merge(user_id: current_user.id)
    end
end
