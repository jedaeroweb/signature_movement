class Admin::ComplimentCategoriesController < Admin::AdminController
  before_action :set_admin_compliment_category, only: [:show, :edit, :update, :destroy]

  def initialize(*params)
    super(*params)

    @category = t(:menu_main_board,scope:[:admin_menu])
    @controller_name = t('activerecord.models.compliment_category')
  end

  # GET /admin/compliment_categories
  # GET /admin/compliment_categories.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    @admin_compliment_categories = ComplimentCategory.order('id desc').page(params[:page]).per(params[:per_page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @admin_compliment_categories }
    end
  end

  # GET /admin/compliment_categories/1
  # GET /admin/compliment_categories/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @admin_compliment_category }
    end
  end

  # GET /admin/compliment_categories/new
  # GET /admin/compliment_categories/new.json
  def new
    @admin_compliment_category = ComplimentCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @admin_compliment_category }
    end
  end

  # GET /admin/compliment_categories/1/edit
  def edit
  end

  # POST /admin/compliment_categories
  # POST /admin/compliment_categories.json
  def create
    @admin_compliment_category = ComplimentCategory.new(admin_compliment_category_params)

    respond_to do |format|
      if @admin_compliment_category.save
        format.html { redirect_to admin_compliment_category_path(@admin_compliment_category), notice: @controller_name +t(:message_success_create)}
        format.json { render :json => @admin_compliment_category, :status => :created, :location => @admin_compliment_category }
      else
        format.html { render :action => "new" }
        format.json { render :json => @admin_compliment_category.errors, :status => :unprocessable_content }
      end
    end
  end

  # PUT /admin/compliment_categories/1
  # PUT /admin/compliment_categories/1.json
  def update
    respond_to do |format|
      if @admin_compliment_category.update(admin_compliment_category_params)
        format.html { redirect_to admin_compliment_category_path(@admin_compliment_category), notice: @controller_name +t(:message_success_update)}
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @admin_compliment_category.errors, :status => :unprocessable_content }
      end
    end
  end

  # DELETE /admin/compliment_categories/1
  # DELETE /admin/compliment_categories/1.json
  def destroy
    @admin_compliment_category.destroy

    respond_to do |format|
      format.html { redirect_to admin_compliment_categories_path}
      format.json { head :ok }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_compliment_category
    @admin_compliment_category = ComplimentCategory.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_compliment_category_params
    params.require(:compliment_category).permit(:compliment_category_id,:title,:enable)
  end
end
