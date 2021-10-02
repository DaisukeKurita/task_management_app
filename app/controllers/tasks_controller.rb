class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    if params[:sort_expired]
      @tasks = Task.end_deadline_descending.page(params[:page]).per(5)
    elsif params[:sort_priority]
      @tasks = Task.highest_priority.page(params[:page]).per(5)
    elsif params[:task].present?
      if params[:task][:search].present? && params[:task][:status].present?
        @tasks = Task.search_task_name(params[:task][:search]).search_status(params[:task][:status]).page(params[:page]).per(5)
      elsif params[:task][:search].present?
        @tasks = Task.search_task_name(params[:task][:search]).page(params[:page]).per(5)
      elsif params[:task][:status].present?
        @tasks = Task.search_status(params[:task][:status]).page(params[:page]).per(5)
      else
        @tasks = Task.creation_date_descending.page(params[:page]).per(5)
      end
    else
      @tasks = Task.creation_date_descending.page(params[:page]).per(5)
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)
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
    params.require(:task).permit(:task_name, :task_detail, :expired_at, :status, :priority).merge(user_id: current_user.id)
  end
end
