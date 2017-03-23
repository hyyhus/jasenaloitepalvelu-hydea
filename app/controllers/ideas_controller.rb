class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy, :publish, :publish_moderate, :un_moderate, :moderate, :reject, :changing, :changed, :not_changed, :like, :unlike]
  before_action :ensure_that_signed_in, except: [:index, :show]
  before_action :ensure_that_is_moderator, except: [:index, :show, :new, :create, :like, :unlike]
#  before_action :set_idea, only: [:publish]


  # GET /ideas
  # GET /ideas.json
  def index
    if params[:basket]
      if (params[:basket] == 'New' or params[:basket] == 'Rejected') and not current_user.moderator?
        redirect_to '/ideas?basket=Approved'
      end
      @ideas = Idea.all.select{|i| i.basket == params[:basket].to_s}
    else
      redirect_to '/ideas?basket=Approved'
    end
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show; end

  # GET /ideas/new
  def new
    @idea = Idea.new
  end

  # GET /ideas/1/edit
  def edit; end

  # POST /ideas
  # POST /ideas.json
  def create
    @history = History.new
    @history.basket = 'New'
    @history.time = Time.now
    @history.user = current_user
    @idea = Idea.new(idea_params)
    @idea.histories << @history
    @history.idea = @idea

    if params[:idea][:tags]
      params[:idea][:tags].each do |tag|
        Tag.all.each do |t|
          if t.text == tag
            @idea.tags << t
          end
        end
      end
    end

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
    if params[:idea].nil?      
      @idea.tags.delete_all
      redirect_to @idea, notice: 'Idea was successfully updated.' and return
    elsif params[:idea][:tags]      
      @idea.tags.delete_all
      params[:idea][:tags].each do |tag|
        newTag = Tag.find_by text: tag
        @idea.tags << newTag
      end
    end   

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
      @idea.histories << History.create(time: Time.now, basket: 'Approved', user: current_user, idea: @idea)
    end
    redirect_to ideas_path
  end

  def publish_moderate
    if current_user.moderator?
      @idea.histories << History.create(time: Time.now, basket: 'Approved', user: current_user, idea: @idea)
      moderate
    end
  end

  def moderate
    if current_user.moderator?
      @idea.moderate = true
      @idea.save
    end
    redirect_to @idea, notice: 'Comments moderation enabled'
  end

  def un_moderate
    if current_user.moderator?
      @idea.moderate = false
      @idea.save
    end
    redirect_to @idea, notice: 'Comments moderation disabled'
  end

  def reject
    if current_user.moderator?
      @idea.histories << History.create(time: Time.now, basket: 'Rejected', user: current_user, idea: @idea)
    end
    redirect_to ideas_path
  end

  def changing
    if current_user.moderator?
      @idea.histories << History.create(time: Time.now, basket: 'Changing', user: current_user, idea: @idea)
    end
    redirect_to ideas_path
  end

  def changed
    if current_user.moderator?
      @idea.histories << History.create(time: Time.now, basket: 'Changed', user: current_user, idea: @idea)
    end
    redirect_to ideas_path
  end

  def not_changed
    if current_user.moderator?
      @idea.histories << History.create(time: Time.now, basket: 'Not Changed', user: current_user, idea: @idea)
    end
    redirect_to ideas_path
  end

  def like
	  @idea.likes << Like.create(user: current_user, idea: @idea, like_type: "like")
	  redirect_to :back
  end

  def unlike
	  @idea.likes.find_by(user_id: current_user).destroy
	  redirect_to :back
  end

  private

   def set_idea
      @idea = Idea.find(params[:id])
   end


    # Never trust parameters from the scary internet, only allow the white list through.
    def idea_params
      params.require(:idea).permit(:topic, :text, :basket, :histories, :tags, :moderate)
    end
end
