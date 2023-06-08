class Api::V1::TasksController < ApplicationController
  before_action :set_task, only: [:show, :update, :destroy]

  def index
    status = params[:status]
    if status.nil?
      @tasks = Task.all
    else
      @tasks = Task.filter_by("status", status)
    end

    render json: {data: @tasks}, status: :ok
  end

  def create
    task = Task.new({ name: task_params[:name], status: 'open' })
    if task.valid?
      task.save
      render json: {}, status: :created
    end
  end

  def show
    render json: {data: @task}, status: :ok
  end

  def destroy
    @task.destroy
    render status: :no_content
  end

  def update
    if @task.update(task_params)
      render status: :ok
    else
      error_response
    end
  end

  private
    def task_params
      params.permit(:name, :status)
    end

    def set_task
      @task = Task.find(params[:id])
      render json: { message: 'Could not find Task with id = ' + params[:id] }, status: :error if @task.nil?
    end

    def error_response(status = :error)
      json_response(message: :error, status: status)
    end
end
