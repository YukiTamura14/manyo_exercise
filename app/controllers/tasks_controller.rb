class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @search_task = Task.new
    @tasks = current_user.tasks.recent.page(params[:page])

    if params[:task].present?
      @tasks = current_user.tasks.title_search(params[:task][:name]).page(params[:page])
      if params[:task][:status].present?
        @tasks = current_user.tasks.status_search(params[:task][:status]).page(params[:page])
      end
      if params[:task][:label_id].present?
        @tasks = current_user.tasks.label_search(params[:task][:label_id]).page(params[:page])
      end
    end

    @tasks = current_user.tasks.sort_expired.page(params[:page]) if params[:sort_expired] == 'true'
    @tasks = current_user.tasks.sort_priority.page(params[:page]) if params[:sort_priority] == 'true'
  end

  def new
    if params[:back]
      @task = current_user.tasks.build(task_params)
      @task.labels.build
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
    @label_ids = @task.labelings.pluck(:label_id)
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
  params.require(:task).permit(:name, :detail, :expired_at, :status, :priority, label_ids: [])
end

def set_task
  @task = current_user.tasks.find(params[:id])
end
