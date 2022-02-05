class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]


  def total_tasks
    @total_tasks ||= @tasks.count
  end

  def completed_tasks
    @completed_task ||= Task.where(completed: 1).count
  end

  def percent_completed
    return 0 if @total_tasks == 0
    (completed_tasks.to_f / total_tasks) * 100
  end

  def index
    @tasks = Task.all
    percent_completed

    @task = Task.new
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)

    
    if @task.save
      redirect_to(tasks_path)
    end
    
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :status, :completed)
    end
end
