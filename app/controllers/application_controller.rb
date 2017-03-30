class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :ensure_that_signed_in, :ensure_that_is_admin, :ensure_that_is_moderator, :set_locale

  before_action :set_locale
  private
   def set_locale
    I18n.locale = session[:locale] || :fin
    session[:locale] = I18n.locale
  end

  def current_user
    return nil if session[:user_id].nil?
    User.find_by(id: session[:user_id])
  end

  def ensure_that_signed_in
    redirect_to ideas_path, notice: 'you should be signed in' if current_user.nil?
  end

  def ensure_that_is_admin
    redirect_to ideas_path if current_user.nil? || !current_user.admin
  end

  def ensure_that_is_moderator
    redirect_to ideas_path if current_user.nil? || !current_user.moderator
  end

end
