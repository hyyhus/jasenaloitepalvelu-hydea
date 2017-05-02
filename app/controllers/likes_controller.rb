class LikesController < ApplicationController
  before_action :set_like, only: [:destroy]


  # POST /likes
  # POST /likes.json
  def create
    @like = Like.new(like_params)
    @like.user = current_user

    respond_to do |format|
      if @like.save
        format.html { redirect_to ideas_path, notice: (t :like) + " " + (t :create) }
      else
			  format.html { redirect_to ideas_url }
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
		  end
	  else
		  respond_to do |format|
			  format.html { redirect_to ideas_url, notice: (t :destroy_only_own_like) }
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
