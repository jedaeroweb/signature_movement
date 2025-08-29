class ProposesController < ApplicationController
  load_and_authorize_resource  except: [:index, :show, :create]  
  before_action :set_propose, only: [:show, :edit, :update, :destroy]

  def initialize(*params)
    super(*params)
    @controller_name=t('activerecord.models.propose')
    @title=@controller_name
  end

  # GET /proposes
  # GET /proposes.json
  def index
    @proposes = Propose.order('id desc').page(params[:page]).per(5)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @proposes }
    end
  end

  # GET /proposes/1
  # GET /proposes/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @propose }
    end
  end

  # GET /proposes/new
  # GET /proposes/new.json
  def new
    @propose = Propose.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @propose }
    end
  end

  # GET /proposes/1/edit
  def edit
  end

  # POST /proposes
  # POST /proposes.json
  def create
    @propose=Propose.new(propose_params)
    @propose.user_id=current_user.id

    respond_to do |format|
      if @propose.save
        format.html { redirect_to proposes_url, :notice=> @controller_name +t(:message_success_create)}
        format.json { render json: @propose, status: :created, location: @propose }
      else
        format.html { render action: "new" }
        format.json { render json: @propose.errors, status: :unprocessable_content }
      end
    end
  end

  # PUT /proposes/1
  # PUT /proposes/1.json
  def update
    respond_to do |format|
      if @propose.update(propose_params)
        format.html { redirect_to proposes_url, :notice=> @controller_name +t(:message_success_update)}
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @propose.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /proposes/1
  # DELETE /proposes/1.json
  def destroy
    @propose.destroy
    respond_to do |format|
      format.html { redirect_to proposes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_compliment
      @propose = Propose.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def propose_params
      params.require(:propose).permit(:id,:title,:content)
    end
end
