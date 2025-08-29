class Admin::BanksController < Admin::AdminController
  before_action :set_admin_bank, only: [:show, :edit, :update, :destroy]

  def initialize(*params)
    super(*params)

    @category = t(:menu_etc_board,scope:[:admin_menu])
    @controller_name = t('activerecord.models.bank')
  end

  # GET /admin/models
  # GET /admin/models.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    @admin_banks = Bank.order('id desc').page(params[:page]).per(params[:per_page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_banks }
    end
  end

  # GET /admin/models/1
  # GET /admin/models/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_bank }
    end
  end

  # GET /admin/models/new
  # GET /admin/models/new.json
  def new
    @admin_bank = Bank.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_bank }
    end
  end

  # GET /admin/models/1/edit
  def edit
  end

  # POST /admin/models
  # POST /admin/models.json
  def create
    @admin_bank = Bank.new(admin_bank_params)

    respond_to do |format|
      if @admin_bank.save
        format.html { redirect_to admin_bank_path(@admin_bank), notice: @controller_name + t(:message_success_create)}
        format.json { render json: @admin_bank, status: :created, location: @admin_bank }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_bank.errors, status: :unprocessable_content }
      end
    end
  end

  # PUT /admin/models/1
  # PUT /admin/models/1.json
  def update
    respond_to do |format|
      if @admin_bank.update(admin_bank_params)
        format.html { redirect_to admin_bank_path(@admin_bank), notice: @controller_name + t(:message_success_update)}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_bank.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /admin/models/1
  # DELETE /admin/models/1.json
  def destroy
    @admin_bank.destroy

    respond_to do |format|
      format.html { redirect_to admin_banks_path }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_bank
    @admin_bank = Bank.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_bank_params
    params.require(:bank).permit(:title, :enable)
  end
end
