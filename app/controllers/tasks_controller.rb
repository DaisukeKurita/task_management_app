class TasksController < ApplicationController
  before_action :set_task, only: %i[ edit ]
  def index
    @tasks = Task.all
  end
  def new
    @task = Task.new
  end
  def edit
  end
  private
  def set_task
    @task = Task.find(params[:id])
  end
end
