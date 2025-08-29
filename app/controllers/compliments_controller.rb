class ComplimentsController < BoardController
  load_and_authorize_resource  except: [:index, :show, :create]
  impressionist :actions=>[:show]
  before_action :set_compliment, only: [:show, :edit, :update, :destroy, :upvote, :downvote]

  def initialize(*params)
    super(*params)
    @controller_name=t('activerecord.models.compliment')
    @title=@controller_name
  end

  # GET /notices
  # GET /notices.json
  def index
    @compliments = Compliment.order('id desc').page(params[:page]).per(10)
  end

  # GET /notices/1
  # GET /notices/1.json
  def show
    @title=@compliment.title
    @meta_description=@compliment.content.to_s
    @comment  = Comment.build_from(@compliment, current_user, "")
  end

  # GET /notices/new
  def new
    @compliment = Compliment.new
  end

  # GET /notices/1/edit
  def edit
    if @compliment.user_id!=current_user.id
      redirect_to @compliment, :alert=> "권한이 없습니다."
    end
  end

  # POST /compliments
  # POST /compliments.json
  def create
    @compliment = Compliment.new(compliment_params)

    respond_to do |format|
      if @compliment.save
        format.html { redirect_to @compliment, :notice=> @controller_name +t(:message_success_create)}
        format.json { render json: @compliment, status: :created, location: @compliment }
      else
        format.html { render action: "new" }
        format.json { render json: @compliment.errors, status: :unprocessable_content }
      end
    end
  end

  # PUT /compliments/1
  # PUT /compliments/1.json
  def update
    respond_to do |format|
      if @compliment.update(compliment_params)
        format.html { redirect_to @compliment, :notice=> @controller_name +t(:message_success_update)}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @compliment.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /compliments/1
  # DELETE /compliments/1.json
  def destroy
    @compliment.destroy
    respond_to do |format|
      format.html { redirect_to compliments_url }
      format.json { head :no_content }
    end
  end

  def upvote
    respond_to do |format|
      if @compliment.liked_by current_user
        format.html { redirect_to compliment_path(@compliment), :notice => t(:message_success_recommend)}
        format.json { render :json => {'vote_up'=>@compliment.cached_votes_up}}
      else
        format.html { render :action => "index" }
        format.json { render :json => @compliment.errors, :status => :unprocessable_content }
      end
    end
  end

  def downvote
    respond_to do |format|
      if @compliment.downvote_from current_user
        format.html { redirect_to compliment_path(@compliment), :notice => t(:message_success_recommend)}
        format.json { render :json => {'vote_up'=>@compliment.cached_votes_down}}
      else
        format.html { render :action => "index" }
        format.json { render :json => @compliment.errors, :status => :unprocessable_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_compliment
      @compliment = Compliment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def compliment_params
      params.require(:compliment).permit(:compliment_category_id, :bank_id, :title, :content).merge(user_id: current_user.id)
    end
end
