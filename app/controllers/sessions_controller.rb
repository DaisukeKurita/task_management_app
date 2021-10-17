class SessionsController < ApplicationController
  skip_before_action :login_required, only: %i[ new create ]

  def new
    redirect_to tasks_path if logged_in?
  end

  def create
    if logged_in?
      redirect_to tasks_path
    else
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        redirect_to user_path(user.id)
      else
        flash.now[:danger] = t('notice.Failed to login')
        render :new
      end
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = t('notice.Logged out')
    redirect_to new_session_path
  end
end
