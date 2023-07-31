class SessionsController < ApplicationController
  before_action :redirect_to_dashboard, if: :current_user, only: [:new, :create]
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    # Render the sign-in form
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Logged in successfully."
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out successfully."
  end

  private

  def redirect_to_dashboard
    redirect_to dashboard_path, notice: "You are already logged in."
  end
end
