class LikesController < ApplicationController
  before_action :set_like, only: [:show, :edit, :update, :destroy]

  # GET /likes
  # GET /likes.json
  def index
    @likes = Like.all
  end

  # GET /likes/1
  # GET /likes/1.json
  def show
  end

  # GET /likes/new
  def new
    @like = Like.new
  end

  # GET /likes/1/edit
  def edit
  end

  # POST /likes
  # POST /likes.json
  def create
    @like = Like.new(like_params)
    @like.user = current_user

    respond_to do |format|
      if @like.save
        format.html { redirect_to ideas_path, notice: (t :like) + " " + (t :create) }
        format.json { render :show, status: :created, location: ideas}
      else
        format.html { render :new }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /likes/1
  # PATCH/PUT /likes/1.json
  def update
    respond_to do |format|
      if @like.update(like_params)
        format.html { redirect_to @like, notice: (t :like) + " " + (t :update) }
        format.json { render :show, status: :ok, location: @like }
      else
        format.html { render :edit }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1
  # DELETE /likes/1.json
  def destroy
	  if @like.user==current_user
		  @like.destroy
		  respond_to do |format|
			  format.html { redirect_to likes_url, notice: (t :like) + " " + (t :destroy)  }
			  format.json { head :no_content }
		  end
	  else
		  respond_to do |format|
			  format.html { redirect_to ideas_url, notice: (t :destroy_only_own_like) }
			  format.json { head :no_content }
		  end
	  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_like
      @like = Like.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def like_params
      params.require(:like).permit(:like_type, :idea_id)
    end
end
