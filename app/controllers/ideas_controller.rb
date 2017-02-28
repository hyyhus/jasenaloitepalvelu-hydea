class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy, :publish]
#  before_action :set_idea, only: [:publish]

  # GET /ideas
  # GET /ideas.json
  def index
	  if params[:basket]
	  #basket = Basket.find_by(name: params[:basket].to_s).id
	  #@ideas = Idea.all.where(basket: basket)
    #@ideas = Idea.all
    @allideas = Idea.all    
    baskets = @allideas.each { |allideas| allideas.histories.last.basket }
    @ideas = baskets.where(basket: basket)

	  else
    @ideas = Idea.all
	  end
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
    
  end

  # GET /ideas/new
  def new
    @idea = Idea.new
  end

  # GET /ideas/1/edit
  def edit
  end

  # POST /ideas
  # POST /ideas.json
  def create
    if not current_user.nil?
    @idea = Idea.new(idea_params)
    @history = History.new
    @history.basket="New"
    @history.user=current_user
    @history.idea=@idea


      respond_to do |format|
	     if @idea.save && @history.save
          format.html { redirect_to @idea, notice: 'Idea was successfully created.' }
          format.json { render :show, status: :created, location: @idea }
        else
          format.html { render :new }
          format.json { render json: @idea.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to ideas_path
    end
  end

  # PATCH/PUT /ideas/1
  # PATCH/PUT /ideas/1.json
  def update
    if not current_user.nil?
    respond_to do |format|
        if @idea.update(idea_params)
        format.html { redirect_to @idea, notice: 'Idea was successfully updated.' }
        format.json { render :show, status: :ok, location: @idea }
        else
        format.html { render :edit }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to ideas_path
    end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    if not current_user.nil?
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to ideas_url, notice: 'Idea was successfully destroyed.' }
      format.json { head :no_content }
    end
    else
      redirect_to ideas_path
    end
  end
  
  def publish

	  if current_user.moderator?
	  history = History.new
	  history.time=Time.now
	  history.basket="Approved"
	  history.user=current_user
	  history.idea=@idea
	  history.save
	  end
	  redirect_to ideas_path

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_idea
      @idea = Idea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def idea_params
      params.require(:idea).permit(:topic, :text, :basket)
    end
end
