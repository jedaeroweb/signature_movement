class Admin::AdModelsController < Admin::AdminController
  before_action :set_model, only: [:show, :edit, :update, :destroy]

  # GET /admin/ad_models
  # GET /admin/ad_models.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    @admin_models = AdModel.order('id desc').page(params[:page]).per(params[:per_page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_models }
    end
  end

  # GET /admin/ad_models/1
  # GET /admin/ad_models/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_model }
    end
  end

  # GET /admin/ad_models/new
  # GET /admin/ad_models/new.json
  def new
    @admin_model = AdModel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_model }
    end
  end

  # GET /admin/ad_models/1/edit
  def edit
  end

  # POST /admin/ad_models
  # POST /admin/ad_models.json
  def create
    @admin_model = AdModel.new(ad_model_params)


    if @admin_model.save
      redirect_to admin_ad_model_path(@admin_model), notice: '문의가 등록되었습니다.'
    else
      render :new, status: :unprocessable_content
    end
  end

  # PUT /admin/ad_models/1
  # PUT /admin/ad_models/1.json
  def update
    respond_to do |format|
      if @admin_model.update(ad_model_params)
        format.html { redirect_to admin_model_path(@admin_model), notice: t(:ad_model, scope: [:activerecord, :ad_models]) + t(:message_success_update)}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_model.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /admin/ad_models/1
  # DELETE /admin/ad_models/1.json
  def destroy
    @admin_model.destroy

    respond_to do |format|
      format.html { redirect_to admin_models_path}
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_model
    @admin_model = AdModel.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ad_model_params
    params.require(:ad_model).permit(:title, :photo, :photo_cache, :description, :content, :enable).merge(user_id: current_user.id)
  end
end
