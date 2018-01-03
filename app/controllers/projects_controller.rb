class ProjectsController < ApplicationController

  def index
    @freelance_work = Project.retrieve_projects("Freelance Work")
    @portfolio = Project.retrieve_projects("Portfolio")
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.order_listed.nil? 
      @project.order_listed = Project.retrieve_projects(@project.work_type).count + 1
    end
    if @project.save
      Project.create_increment_order(@project.id, @project.order_listed, @project.work_type)
      redirect_to projects_path 
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    cache_project_order = @project.order_listed
    cache_project_type = @project.work_type
    if @project.update(project_params)
      if @project.order_listed.nil?
        @project.order_listed = Project.retrieve_projects(@project.work_type).count
        Project.update_increment_order(@project.id, @project.order_listed,cache_project_order, @project.work_type, cache_project_type)
        @project.save
      else
        Project.update_increment_order(@project.id, @project.order_listed,cache_project_order, @project.work_type, cache_project_type)
      end
      redirect_to projects_path 
    else
      render :new
    end
  end

  def destroy
    @project = Project.find(params[:id])
    Project.decrement_order(@project.id, @project.order_listed, @project.work_type)
    @project.destroy
    redirect_to projects_path
  end

private

  def project_params
    params.require(:project).permit(:title, :description, :link, :video_source, :work_type, :order_listed)
  end

end