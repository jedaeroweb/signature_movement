class AdModelsController < ApplicationController
  load_and_authorize_resource  except: [:index, :show, :create]
  before_action :set_model, only: [:show, :edit, :update, :destroy, :upvote, :downvote]

  def initialize(*params)
    super(*params)
    @controller_name=t('activerecord.models.ad_model')
    @title=@controller_name
  end

  # GET /notices
  # GET /notices.json
  def index
    @ad_models = AdModel.order('id desc').page(params[:page]).per(5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ad_models }
    end
  end

  # GET /notices/1
  # GET /notices/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ad_model }
    end
  end

  # GET /notices/new
  # GET /notices/new.json
  def new
    @ad_model = AdModel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ad_model }
    end
  end

  # GET /notices/1/edit
  def edit
  end

  # POST /notices
  # POST /notices.json
  def create
    @ad_model = AdModel.new(model_params)
    @ad_model.user_id=current_user.id

    if @ad_model.save
      redirect_to ad_model_path(@ad_model), notice: '문의가 등록되었습니다.'
    else
      render new_ad_model_path, status: :unprocessable_content
    end
  end

  # PUT /notices/1
  # PUT /notices/1.json
  def update
    respond_to do |format|
      if @ad_model.update(model_params)
        format.html { redirect_to @ad_model, :notice=> @controller_name +t(:message_success_update)}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ad_model.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /notices/1
  # DELETE /notices/1.json
  def destroy
    @ad_model.destroy
    respond_to do |format|
      format.html { redirect_to ad_models_path }
      format.json { head :no_content }
    end
  end

  def upvote
    respond_to do |format|
      if @ad_model.liked_by current_user
        format.html { redirect_to model_path(@ad_model), :notice => t(:message_success_recommend)}
        format.json { render :json => {'vote_up'=>@ad_model.cached_votes_up}}
      else
        format.html { render :action => "index" }
        format.json { render :json => @ad_model.errors, :status => :unprocessable_content }
      end
    end
  end

  def downvote
    respond_to do |format|
      if @ad_model.downvote_from current_user
        format.html { redirect_to model_path(@ad_model), :notice => t(:message_success_recommend)}
        format.json { render :json => {'vote_up'=>@ad_model.cached_votes_down}}
      else
        format.html { render :action => "index" }
        format.json { render :json => @ad_model.errors, :status => :unprocessable_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_model
      @ad_model = AdModel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def model_params
      params.require(:ad_model).permit(:id, :title, :description, :content , :photo, :photo_cache)
    end
end
