class JobsController < ApplicationController
  # def index
  #   render json: Job.all
  #
  # end
  #
  # def show
  #   render json: Job.find(params[:id])
  # end
  #
  # def create
  #   job = Job.new(job_params)
  #
  #   if job.save
  #     render json: job
  #   else
  #     render json: { error: "Job could not be created." }, status: 422
  #   end
  # end

  def update
    job = Job.find(params[:id])

    if job.update_attributes(job_params)
      render json: job
    else
      render json: { error: "Job could not be updated." }, status: 422
    end
  end

  # def destroy
  #   Job.find(params[:id]).destroy
  #
  #   head :ok
  #   # head 200
  # end

  private

  def job_params
    params.require(:job).permit([
      :start_date,
      :end_date,
      :salary
    ])
  end
end
