class UsersController < ApplicationController
  skip_before_action :login_required, only: %i[ new create ]
  before_action :set_user, only: %i[ show destroy ]
  before_action :back_when_logged_in, only: %i[ new create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id), notice: t('notice.User was successfully created', name: @user.user_name)
    else
      render :new
    end
  end

  def show
    redirect_to tasks_path unless @user.id == current_user.id
  end


  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_name, :email, :admin, :password,:password_confirmation)
  end

  def back_when_logged_in
    redirect_to tasks_path if logged_in?
  end
end
