class IdeasController < ApplicationController
  before_action :set_idea, only: [:show, :edit, :update, :destroy, :publish, :publish_moderate, :un_moderate, :moderate, :reject, :changing, :changed, :not_changed, :like, :unlike]
  before_action :ensure_that_signed_in, except: [:index, :show]
  before_action :ensure_that_is_moderator, except: [:index, :show, :new, :create, :like, :unlike]
#  before_action :set_idea, only: [:publish]


  # GET /ideas
  # GET /ideas.json
  def index
    @q = Idea.ransack(params[:q])
    @q.sorts = 'created_at' if @q.sorts.empty?
    @idea = @q.result(distinct: true)
    if params[:basket]
      if (params[:basket] == 'New' or params[:basket] == 'Rejected') and not current_user.moderator?
        redirect_to '/ideas?basket=Approved'
      end
      tags = []
      params.keys.each{|k| if Tag.all.find_by(text: k) then tags<<k end}
      if tags.empty? then
      @ideas = @idea.all.select{|i| i.basket == params[:basket].to_s }
      else
      @ideas = @idea.all.select{|i| i.basket == params[:basket].to_s and i.tags.find_by(text: tags)}
      end
    else
      redirect_to '/ideas?basket=Approved'
    end
  end

  # GET /ideas/1
  # GET /ideas/1.json
  def show
    if current_user.nil? && @idea.basket == "Rejected"
      redirect_to '/ideas?basket=Approved' and return
    elsif current_user.nil? && @idea.basket != "New"
      #Näytetään idea normaalisti, jos julkaistu.
    elsif current_user.nil? && @idea.basket == "New"
      redirect_to '/ideas?basket=Approved' and return
    elsif current_user.moderator?
      #Näytetään idea normaalisti kaikille moderaattoreille.
    elsif @idea.basket == "Rejected"
      redirect_to '/ideas?basket=Approved' and return
    elsif @idea.basket == "New" && current_user.id.to_s != @idea.histories.find_by(basket: "New").user_id
      redirect_to '/ideas?basket=Approved' and return
    end
    #Näytetään käyttäjälle hänen oma ideansa
  end

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
    @idea.moderate = false
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
          format.html { redirect_to @idea, notice: (t :idea) + " " + (t :create) }
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
      redirect_to @idea, notice: (t :idea) + " " + (t :update) and return
    elsif params[:idea][:tags]
      @idea.tags.delete_all
      params[:idea][:tags].each do |tag|
        newTag = Tag.find_by text: tag
        @idea.tags << newTag
      end
    end

    respond_to do |format|
      if @idea.update(idea_params)
        format.html { redirect_to @idea, notice: (t :idea) + " " + (t :update) }
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
      format.html { redirect_to ideas_url, notice: (t :idea) + " " + (t :destroy)  }
      format.json { head :no_content }
    end
  end

  def publish
    @idea.histories << History.create(time: Time.now, basket: 'Approved', user: current_user, idea: @idea)
    redirect_to ideas_path
  end

  def publish_moderate
      @idea.histories << History.create(time: Time.now, basket: 'Approved', user: current_user, idea: @idea)
      moderate
  end

  def moderate
    @idea.moderate = true
    @idea.save
    redirect_to @idea, notice: (t :comment_moderation_enable)
  end

  def un_moderate
    @idea.moderate = false
    @idea.save
    redirect_to @idea, notice: (t :comment_moderation_disable)
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
	  redirect_back(fallback_location: '/')
  end

  def unlike
	  @idea.likes.find_by(user_id: current_user).destroy
	  redirect_back(fallback_location: '/')
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
