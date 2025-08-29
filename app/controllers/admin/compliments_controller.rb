class Admin::ComplimentsController < Admin::AdminController
  before_action :set_admin_compliment, only: [:show, :edit, :update, :destroy]

  def initialize(*params)
    super(*params)

    @category = t(:menu_main_board,scope:[:admin_menu])
    @controller_name = t('activerecord.models.compliment')
  end

  # GET /admin/compliments
  # GET /admin/compliments.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    @admin_compliments = Compliment.order('id desc').page(params[:page]).per(params[:per_page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_compliments }
    end
  end

  # GET /admin/compliments/1
  # GET /admin/compliments/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_compliment }
    end
  end

  # GET /admin/compliments/new
  # GET /admin/compliments/new.json
  def new
    @admin_compliment = Compliment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_compliment }
    end
  end

  # GET /compliments/1/edit
  def edit
  end

  # POST /admin/compliments
  # POST /admin/compliments.json
  def create
    @admin_compliment = Compliment.new(admin_compliment_params)

    respond_to do |format|
      if @admin_compliment.save
        format.html { redirect_to admin_compliment_path(@admin_compliment), notice: @controller_name + t(:message_success_create)}
        format.json { render json: @admin_compliment, status: :created, location: @admin_compliment }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_compliment.errors, status: :unprocessable_content }
      end
    end
  end

  # PUT /admin/compliments/1
  # PUT /admin/compliments/1.json
  def update
    respond_to do |format|
      if @admin_compliment.update(admin_compliment_params)
        format.html { redirect_to admin_compliment_path(@admin_compliment), notice: @controller_name + t(:message_success_update)}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_compliment.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /admin/compliments/1
  # DELETE /admin/compliments/1.json
  def destroy
    @admin_compliment.destroy

    respond_to do |format|
      format.html { redirect_to admin_compliments_path}
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_compliment
    @admin_compliment = Compliment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_compliment_params
    params.require(:compliment).permit(:compliment_category_id, :bank_id, :title, :content).merge(user_id: current_user.id)
  end
end
