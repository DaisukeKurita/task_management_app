class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]

  def index
    @tasks = current_user.tasks.includes(:labels).order(created_at: :desc)
    @tasks = @tasks.reorder(expired_at: :desc) if params[:sort_expired]
    @tasks = @tasks.reorder(priority: :asc) if params[:sort_priority]
    @tasks = @tasks.search_task_name(params[:search]) if params[:search].present?
    @tasks = @tasks.search_status(params[:status]) if params[:status].present?
    @tasks = @tasks.search_labels(params[:label_id]) if params[:label_id].present?

    @tasks = @tasks.page(params[:page]).per(5)
    # @tasks = current_user.tasks.includes([:labels]).creation_date_descending.page(params[:page]).per(5)
    # @tasks = current_user.tasks.includes([:labels]).end_deadline_descending.page(params[:page]).per(5) if params[:sort_expired] 
    # @tasks = current_user.tasks.includes([:labels]).highest_priority.page(params[:page]).per(5) if params[:sort_priority]
    # if params[:task].present?
    #   if params[:task][:search].present? && params[:task][:status].present? && params[:task][:label_id].present? # タスク名、ステータス、ラベル検索
    #     @tasks = current_user.tasks.search_task_name(params[:task][:search]).search_status(params[:task][:status]).joins(:labels).search_label(params[:task][:label_id]).includes([:labels]).includes([:labellings]).page(params[:page]).per(5)
    #   elsif params[:task][:search].present? && params[:task][:status].present? # タスク名、ステータス検索
    #     @tasks = current_user.tasks.search_task_name(params[:task][:search]).search_status(params[:task][:status]).includes([:labels]).page(params[:page]).per(5)
    #   elsif params[:task][:search].present? && params[:task][:label_id].present? # タスク名、ラベル検索
    #     @tasks = current_user.tasks.search_task_name(params[:task][:search]).joins(:labels).search_label(params[:task][:label_id]).includes([:labels]).includes([:labellings]).page(params[:page]).per(5)
    #   elsif params[:task][:status].present? && params[:task][:label_id].present? # ステータス、ラベル検索
    #     @tasks = current_user.tasks.search_status(params[:task][:status]).joins(:labels).search_label(params[:task][:label_id]).includes([:labels]).includes([:labellings]).page(params[:page]).per(5)
    #   elsif params[:task][:search].present? # タスク名検索
    #     @tasks = current_user.tasks.search_task_name(params[:task][:search]).includes([:labels]).page(params[:page]).per(5)
    #   elsif params[:task][:status].present? # ステータス検索
    #     @tasks = current_user.tasks.search_status(params[:task][:status]).includes([:labels]).page(params[:page]).per(5)
    #   elsif params[:task][:label_id].present? # ラベル検索
    #     @tasks =  Task.search_label_two(params[:task][:label_id]).includes([:labels]).includes([:user]).page(params[:page]).per(5)
        # @tasks =  Task.where(id: Labelling.where(label_id: (params[:task][:label_id])).pluck(:task_id)).page(params[:page]).per(5)
        # @tasks = current_user.tasks.joins(:labels).search_label(params[:task][:label_id]).page(params[:page]).per(5)
    #   end
    # end
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
    unless params[:task][:label_ids]
      @task.labellings.destroy_all
    end
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
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:task_name, :task_detail, :expired_at, :status, :priority, :user_id, { label_ids: [] })
  end
end
