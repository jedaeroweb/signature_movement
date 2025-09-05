class ImproveController < ApplicationController
  before_action :set_improve, only: [:show, :edit, :update, :destroy]

  def initialize(*params)
    super(*params)
    @controller_name=t('activerecord.models.improve')
    @title=@controller_name
  end
  # GET /improve
  # GET /improve.json
  def index
    @improve = Improve.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @improve }
    end
  end

  # GET /improve/1
  # GET /improve/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @improve }
    end
  end

  # GET /improve/new
  # GET /improve/new.json
  def new
    @improve = Improve.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @improve }
    end
  end

  # GET /improve/1/edit
  def edit
  end

  # POST /improve
  # POST /improve.json
  def create
    @improve = Improve.new(improve_params)
    @improve.content = @improve.raw_content

    if Rails.env.production?
      result= verify_recaptcha(:ad_model => @improve, :message => "Oh! It's error with reCAPTCHA!") && @improve.save
    else
      result=@improve.save
    end

    if @improve.save
      redirect_to @improve, notice: '개선안이 등록되었습니다.'
    else
      render :new, status: :unprocessable_content
    end
  end

  # PUT /improve/1
  # PUT /improve/1.json
  def update
    respond_to do |format|
      if @improve.update(improve_params)
        format.html { redirect_to @improve, :notice=> @controller_name + t(:message_success_update)}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @improve.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /improve/1
  # DELETE /improve/1.json
  def destroy
    @improve.destroy
    respond_to do |format|
      format.html { redirect_to improve_index_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_improve
      @imporve = Improve.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def improve_params
      params.require(:improve).permit(:id,:title, :raw_content)
    end
end
