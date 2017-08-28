class LeadershipJobsController < ApplicationController
  before_action :authenticate_user! # Require admin

  before_action :set_leadership_job, only: [:show, :edit, :update, :destroy]

  # GET /leadership_jobs
  # GET /leadership_jobs.json
  def index
    @leadership_jobs = LeadershipJob.order(pub_date: :desc).page(params[:page])
  end

  # GET /leadership_jobs/1
  # GET /leadership_jobs/1.json
  def show
  end

  # GET /leadership_jobs/new
  def new
    @leadership_job = LeadershipJob.new
  end

  # GET /leadership_jobs/1/edit
  def edit
  end

  # POST /leadership_jobs
  # POST /leadership_jobs.json
  def create
    @leadership_job = LeadershipJob.new(leadership_job_params)

    respond_to do |format|
      if @leadership_job.save
        format.html { redirect_to @leadership_job, notice: 'Leadership job was successfully created.' }
        format.json { render :show, status: :created, location: @leadership_job }
      else
        format.html { render :new }
        format.json { render json: @leadership_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leadership_jobs/1
  # PATCH/PUT /leadership_jobs/1.json
  def update
    respond_to do |format|
      if @leadership_job.update(leadership_job_params)
        format.html { redirect_to @leadership_job, notice: 'Leadership job was successfully updated.' }
        format.json { render :show, status: :ok, location: @leadership_job }
      else
        format.html { render :edit }
        format.json { render json: @leadership_job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leadership_jobs/1
  # DELETE /leadership_jobs/1.json
  def destroy
    @leadership_job.destroy
    respond_to do |format|
      format.html { redirect_to leadership_jobs_url, notice: 'Leadership job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_leadership_job
      @leadership_job = LeadershipJob.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def leadership_job_params
      params.require(:leadership_job).permit(:title, :description, :link, :pub_date, :source, :guid)
    end
end
