class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = current_user.tasks.recent.page(params[:page])

    if params[:task].present? && params[:task][:search] == 'true'
      @tasks = Task.title_search(params[:task][:name]).page(params[:page])
    end
    if params[:task].present? && params[:task][:status].present?
      @tasks = Task.status_search(params[:task][:status]).page(params[:page])
    end
    if params[:task].present? && params[:task][:search] == 'true' && params[:task][:status].present?
      @tasks = Task.title_search(params[:task][:name])
                   .status_search(params[:task][:status]).page(params[:page])
    end

    @tasks = Task.sort_expired.page(params[:page]) if params[:sort_expired] == 'true'
    @tasks = Task.sort_priority.page(params[:page]) if params[:sort_priority] == 'true'
  end

  def new
    if params[:back]
      @task = current_user.tasks.build(task_params)
    else
      @task = Task.new
    end
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def show
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'タスクを削除しました。'
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'タスクを編集しました。'
    else
      render :new
    end
  end
end

private

def task_params
  params.require(:task).permit(:name, :detail, :expired_at, :status, :priority)
end

def set_task
  @task = current_user.tasks.find(params[:id])
end
