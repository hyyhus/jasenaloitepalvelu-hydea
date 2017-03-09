class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy, :publish, :reject, :changing, :changed, :not_changed]
  before_action :ensure_that_signed_in, except: [:index, :show]

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
    if not current_user.nil?
    @idea = Idea.new
    else
      redirect_to ideas_path
    end
  end

  # GET /ideas/1/edit
  def edit
  end

  # POST /ideas
  # POST /ideas.json
  def create
    @history = History.new
    @history.basket = "New"
    @history.time = Time.now
    @history.user = current_user
    @idea = Idea.new(idea_params)
    @idea.histories << @history
    @history.idea = @idea


      respond_to do |format|
	     if @history.save && @idea.save
          format.html { redirect_to @idea, notice: 'Idea was successfully created.' }
          format.json { render :show, status: :created, location: @idea }
        else
          format.html { render :new }
          format.json { render json: @idea.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /ideas/1
  # PATCH/PUT /ideas/1.json
  def update
    respond_to do |format|
        if @idea.update(idea_params)
        format.html { redirect_to @idea, notice: 'Idea was successfully updated.' }
        format.json { render :show, status: :ok, location: @idea }
        else
        format.html { render :edit }
        format.json { render json: @idea.errors, status: :unprocessable_entity }
        end
      end
  end

  # DELETE /ideas/1
  # DELETE /ideas/1.json
  def destroy
    @idea.destroy
    respond_to do |format|
      format.html { redirect_to ideas_url, notice: 'Idea was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def publish

	  if current_user.moderator?
		  @idea.histories << History.create(time: Time.now, basket: "Approved", user: current_user, idea: @idea)
	  end
	  redirect_to ideas_path

  end

  def reject

	  if current_user.moderator?
		  @idea.histories << History.create(time: Time.now, basket: "Rejected", user: current_user, idea: @idea)
	  end
	  redirect_to ideas_path

  end

  def changing

	  if current_user.moderator?
		  @idea.histories << History.create(time: Time.now, basket: "Changing", user: current_user, idea: @idea)
	  end
	  redirect_to ideas_path

  end

  def changed

	  if current_user.moderator?
		  @idea.histories << History.create(time: Time.now, basket: "Changed", user: current_user, idea: @idea)
	  end
	  redirect_to ideas_path

  end

  def not_changed

	  if current_user.moderator?
		  @idea.histories << History.create(time: Time.now, basket: "Not Changed", user: current_user, idea: @idea)
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
      params.require(:idea).permit(:topic, :text, :basket, :histories)
    end
end
