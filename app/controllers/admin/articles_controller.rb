class Admin::ArticlesController < Admin::AdminController
  before_action :set_admin_article, only: [:show, :edit, :update, :destroy]

  def initialize(*params)
    super(*params)

    @category = t(:menu_etc_board,scope:[:admin_menu])
    @controller_name = t('activerecord.models.article')
  end

  # GET /admin/articles
  # GET /admin/articles.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    @admin_articles = Article.order('id desc').page(params[:page]).per(params[:per_page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @admin_articles }
    end
  end

  # GET /admin/articles/1
  # GET /admin/articles/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @admin_article }
    end
  end

  # GET /admin/articles/new
  # GET /admin/articles/new.json
  def new
    @admin_article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @admin_article }
    end
  end

  # GET /admin/articles/1/edit
  def edit
  end

  # POST /admin/articles
  # POST /admin/articles.json
  def create
    @admin_article = Article.new(admin_article_params)

    respond_to do |format|
      if @admin_article.save
        format.html { redirect_to admin_article_path(@admin_article), notice: @controller_name + t(:message_success_create)}
        format.json { render json: @admin_article, status: :created, location: @admin_article }
      else
        format.html { render action: "new" }
        format.json { render json: @admin_article.errors, status: :unprocessable_content }
      end
    end
  end

  # PUT /admin/articles/1
  # PUT /admin/articles/1.json
  def update
    respond_to do |format|
      if @admin_article.update(admin_article_params)
        format.html { redirect_to admin_article_path(@admin_article), notice: @controller_name + t(:message_success_update)}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @admin_article.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /admin/articles/1
  # DELETE /admin/articles/1.json
  def destroy
    @admin_article.destroy

    respond_to do |format|
      format.html { redirect_to admin_articles_path }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_article
    @admin_article = Article.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_article_params
    params.require(:article).permit(:title, :description, :url, :enable)
  end
end
