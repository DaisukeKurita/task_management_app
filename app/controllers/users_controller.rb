class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[ new create ]

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
    @user = User.find(params[:id])
    redirect_to tasks_path unless @user.id == current_user.id
  end

  def index
    @users = User.all
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :email, :password,:password_confirmation)
  end
end
