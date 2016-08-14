class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def current_member
    if session[:member_id]
      @current_member ||= Member.find_by(id: session[:member_id])
    end
  end
  helper_method :current_member
end
