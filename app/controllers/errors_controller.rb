class ErrorsController < ApplicationController
  def error_404
    respond_to do |format|
      format.html { render status: 404 }
      format.any  { redirect_to root_path, notice: "404 page not found" }
    end
  end

  def error_422
    respond_to do |format|
      format.html { render status: 422 }
      format.any  { render text: "422 Unprocessable Entity", status: 422 }
    end
  end

  def error_500
    respond_to do |format|
      format.html { render status: 500 }
      format.any  { render text: "500 Internal server error", status: 500 }
    end
  end
end