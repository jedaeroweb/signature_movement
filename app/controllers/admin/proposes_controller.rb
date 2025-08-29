class Admin::ProposesController < Admin::AdminController
  before_action :set_admin_propose, only: [:show, :edit, :update, :destroy]

  def initialize(*params)
    super(*params)

    @category = t(:menu_etc_board,scope:[:admin_menu])
    @controller_name = t('activerecord.models.propose')
  end

  # GET /admin/proposes
  # GET /admin/proposes.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    @admin_proposes = Propose.order('id desc').page(params[:page]).per(params[:per_page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_proposes }
    end
  end

  # GET /admin/proposes/1
  # GET /admin/proposes/1.json
  def show
    @admin_propose = Propose.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_propose }
    end
  end

  # GET /admin/proposes/new
  # GET /admin/proposes/new.json
  def new
    @admin_propose = Propose.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_propose }
    end
  end

  # GE /admin/proposes/1/edit
  def edit
  end

  # POST /admin/proposes
  # POST /admin/proposes.json
  def create
    @admin_propose = Propose.new(admin_propose_params)

    respond_to do |format|
      if @admin_propose.save
        format.html { redirect_to admin_proposes_url, notice: @controller_name + t(:message_success_create) }
        format.json { render json: @admin_propose, status: :created, location: @admin_propose }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_propose.errors, status: :unprocessable_content }
      end
    end
  end

  # PUT /admin/proposes/1
  # PUT /admin/proposes/1.json
  def update
    respond_to do |format|
      if @admin_propose.update(admin_propose_params)
        format.html { redirect_to admin_proposes_url, notice: @controller_name + t(:message_success_update) }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_propose.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /admin/proposes/1
  # DELETE /admin/proposes/1.json
  def destroy
    @admin_propose.destroy

    respond_to do |format|
      format.html { redirect_to admin_proposes_path}
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_propose
    @admin_propose = Propose.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_propose_params
    params.require(:propose).permit(:title, :content, :enable).merge(user_id: current_admin.id)
  end
end
