class Admin::UsersController < ApplicationController
  skip_before_action :login_required, only: %i[ new create ]
  before_action :set_user, only: %i[ edit update show destroy ]
  before_action :back_when_logged_in, only: %i[ new create ]
  before_action :require_admin

  def index
    @users = User.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to admin_user_path(@user.id), notice: t('notice.User was successfully created', name: @user.user_name)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user.id), notice: t('notice.User was successfully updated', name: @user.user_name)
    else
      render :edit
    end
  end

  def show
    redirect_to tasks_path unless @user.id == current_user.id
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: t('notice.User was successfully destroyed', name: @user.user_name )
    else
      redirect_to admin_users_path, notice: t('notice.The process was rejected because the administrator becomes 0')
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_name, :email, :admin, :password, :password_confirmation)
  end

  def back_when_logged_in
    redirect_to tasks_path if logged_in?
  end

  def require_admin
    redirect_to tasks_path, notice: t('notice.Only the administrator can access it') unless current_user.admin?
  end
end
