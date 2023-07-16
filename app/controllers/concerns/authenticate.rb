module Authenticate
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
    helper_method :current_user
  end

  private
  
  def authenticate_user!
    redirect_to new_session_path unless current_user
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end

