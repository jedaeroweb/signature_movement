class Admin::FaqsController < Admin::AdminController
  before_action :set_admin_faq, only: [:show, :edit, :update, :destroy]

  def initialize(*params)
    super(*params)

    @category = t(:menu_main_board,scope:[:admin_menu])
    @controller_name = t('activerecord.models.faq')
  end

  # GET /admin/faqs
  # GET /admin/faqs.json
  def index
      params[:per_page] = 10 unless params[:per_page].present?

      @admin_faq_categories=FaqCategory.where(:enable=>true)

      if(params[:blog_category_id])
        @admin_faq_category_id=params[:faq_category_id].to_i
        @admin_faqs = Faq.where(:faq_category_id=>@admin_faq_category_id).order(id:'desc').page(params[:page]).per(params[:per_page])
      else
        @admin_faqs = Faq.order('id desc').page(params[:page]).per(params[:per_page])
      end

    respond_to do |format|
      format.html
      format.json { render json: @admin_faqs }
    end
  end

  # GET /admin/faqs/1
  # GET /admin/faqs/1.json
  def show
    @admin_faq_content=FaqContent.find(params[:id])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_faqContent }
    end
  end

  # GET /admin/faqs/new
  # GET /admin/faqs/new.json
  def new
    @admin_faq = Faq.new
    @admin_faq.build_faq_content
    @admin_faq_categories = FaqCategory.all
    @admin_faq_category_id=params[:faq_category_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_faq }
    end
  end

  # GET /admin/faqs/1/edit
  def edit
    @admin_faq_categories = FaqCategory.all
    @admin_faq_category_id=@admin_faq.faq_category.id
  end

  # POST /admin/faqs
  # POST /admin/faqs.json
  def create
    @admin_faq = Faq.new(admin_faq_params)

    respond_to do |format|
      if @admin_faq.save
        format.html { redirect_to admin_faq_path(@admin_faq), :notice=> @controller_name +t(:message_success_create)}
        format.json { render json: @admin_faq, status: :created, location: @admin_faq }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_faq.errors, status: :unprocessable_content }
      end
    end
  end

  # PUT /admin/faqs/1
  # PUT /admin/faqs/1.json
  def update
    @admin_faq = Faq.find(params[:id])

    respond_to do |format|
      if @admin_faq.update(admin_faq_params)
        format.html { redirect_to admin_faq_path(@admin_faq), :notice=> @controller_name +t(:message_success_update)}
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_faq.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /admin/faqs/1
  # DELETE /admin/faqs/1.json
  def destroy
    @admin_faq.destroy

    respond_to do |format|
      format.html { redirect_to admin_faqs_path}
      format.json { head :ok }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin_faq
    @admin_faq = Faq.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_faq_params
    params.require(:faq).permit(:id,:faq_category_id,:title, :enable, faq_content_attributes: [:id,:content])
  end
end
