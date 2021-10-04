class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[ new create ]
  before_action :set_user, only: %i[ show destroy ]

  def new
    if logged_in?
      redirect_to tasks_path
    else
      @user = User.new
    end
  end

  def create
    if logged_in?
      redirect_to tasks_path
    else
      @user = User.new(user_params)
      if @user.save
          session[:user_id] = @user.id
          redirect_to user_path(@user.id), notice: t('notice.User was successfully created')
      else
        render :new
      end
    end
  end

  def show
    redirect_to tasks_path unless @user.id == current_user.id
  end

  def index
    @users = User.all
  end

  def destroy
    @user.destroy
    redirect_to  new_session_path
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_name, :email, :password,:password_confirmation)
  end
end
