class Admin::FaqCategoriesController < Admin::AdminController
  before_action :set_admin_faq_category, only: [:show, :edit, :update, :destroy]

  def initialize(*params)
    super(*params)

    @category = t(:menu_main_board,scope:[:admin_menu])
    @controller_name = t('activerecord.models.faq_category')
  end

  # GET /admin/faq_categories
  # GET /admin/faq_categories.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    @admin_faq_categories = FaqCategory.order('id desc').page(params[:page]).per(params[:per_page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @admin_blog_categories }
    end
  end

  # GET /admin/faq_categories/1
  # GET /admin/faq_categories/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_faq_category }
    end
  end

  # GET /admin/faq_categories/new
  # GET /admin/faq_categories/new.json
  def new
    @admin_faq_category = FaqCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_faq_category }
    end
  end

  # GET /admin/faq_categories/1/edit
  def edit
  end

  # POST /admin/faq_categories
  # POST /admin/faq_categories.json
  def create
    @admin_faq_category = FaqCategory.new(admin_faq_category_params)

    respond_to do |format|
      if @admin_faq_category.save
        format.html { redirect_to admin_faq_category_path(@admin_faq_category), notice: @controller_name + t(:message_success_create)}
        format.json { render json: @admin_faq_category, status: :created, location: @admin_faq_category }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_faq_category.errors, status: :unprocessable_content }
      end
    end
  end

  # PUT /admin/faq_categories/1
  # PUT /admin/faq_categories/1.json
  def update
    respond_to do |format|
      if @admin_faq_category.update(admin_faq_category_params)
        format.html { redirect_to admin_faq_category_path(@admin_faq_category), notice: @controller_name + t(:message_success_update)}
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_faq_category.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /admin/faq_categories/1
  # DELETE /admin/faq_categories/1.json
  def destroy
    @admin_faq_category.destroy

    respond_to do |format|
      format.html { redirect_to admin_faq_categories_path}
      format.json { head :ok }
    end
  end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_faq_category
      @admin_faq_category = FaqCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_faq_category_params
      params.require(:faq_category).permit(:id,:faq_category_id,:title)
    end
end
