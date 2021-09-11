class TasksController < ApplicationController
  before_action :set_task, only: %i[ edit update ]
  def index
    @tasks = Task.all
  end
  def new
    @task = Task.new
  end
  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: "Property was successfully created."
    else
      render :new
    end
  end
  def edit
  end
  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Property was successfully updated."
    else
      render :edit
    end
  end
  private
  def set_task
    @task = Task.find(params[:id])
  end
  def task_params
    params.require(:task).permit(:task_name, :task_detail)
  end
end
