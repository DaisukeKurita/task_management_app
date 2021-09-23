class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  def index
    if params[:sort_expired]
      @tasks = Task.all.order(expired_at: :desc)
    elsif params[:task].present?
      if params[:task][:search].present? && params[:task][:status].present?
        @tasks = Task.where('task_name LIKE ?', "%#{params[:task][:search]}%").where(status: params[:task][:status])
      elsif params[:task][:search].present?
        @tasks = Task.where('task_name LIKE ?', "%#{params[:task][:search]}%")
      elsif params[:task][:status].present?
        @tasks = Task.where(status: params[:task][:status])
      else
        @tasks = Task.all
      end
    else
      @tasks = Task.all.order(created_at: :desc)
    end
  end
  def new
    @task = Task.new
  end
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: t('notice.Task was successfully created')
    else
      render :new
    end
  end
  def show
  end
  def edit
  end
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: t('notice.Task was successfully updated')
    else
      render :edit
    end
  end
  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('notice.Task was successfully destroyed')
  end
  private
  def set_task
    @task = Task.find(params[:id])
  end
  def task_params
    params.require(:task).permit(:task_name, :task_detail, :expired_at, :status)
  end
end
