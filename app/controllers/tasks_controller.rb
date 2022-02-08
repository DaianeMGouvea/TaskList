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
    @percent_completed = (completed_tasks.to_f / total_tasks()) * 100
  end

  def index
    @tasks = Task.all
    percent_completed

    new
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
    @task.status = 'Aberto'
    @task.completed = 0
    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_path }
      else
        format.html { redirect_to tasks_path, notice: "Insira um nome a tarefa" }
        format.json { render json: @task.errors }
      end
    end   
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_path, notice: "Task was successfully updated." }
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
      format.html { redirect_to tasks_path, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:name)
    end
end
