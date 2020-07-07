class TasksController < ApplicationController
  before_action :find_task, only: [:show, :edit, :update, :destroy]

  def index
    @query = Task.ransack(params[:q])
    @query.sorts = 'created_at desc' if @query.sorts.empty?
    @tasks = @query.result.includes(:labels).page(params[:page]).per(10)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.valid?
    @task.save!
    redirect_to tasks_path, notice: "タスクを追加しました" 
  rescue => e
    logger.error e 
    logger.error e.backtrace.join("\n") 
    flash.now[:alert] = "登録に失敗しました"
    render 'new'
  end

  def update
    @task.valid?
    @task.update!(task_params)
    redirect_to tasks_path, notice: "タスクを修正しました"
  rescue => e
    logger.error e 
    logger.error e.backtrace.join("\n") 
    flash.now[:alert] = "更新に失敗しました"
    render 'edit'
  end

  def destroy
    @task.destroy!
    redirect_to tasks_path, notice: "タスクを削除しました"
  rescue => e
    logger.error e 
    logger.error e.backtrace.join("\n") 
    flash.now[:alert] = "削除に失敗しました"
    render 'show'
  end

  private

  def task_params
    params.require(:task).permit(
      :name, :explanation, :deadline,
      :status, :priority, { label_ids: [] }
    )
  end

  def find_task
    @task = Task.find(params[:id])
  end
end
