class ProjectsController < ApplicationController
    skip_before_action :authorize, only: [:create, :index, :show, :update, :destroy]
    
    def create
        dev = find_dev
        # dev = Developer.first
        project = dev.projects.create!(project_params)
        render json: project, status: :created
    end

    def update
        project = Project.find_by_id(params[:id]) 
        render json: project.update!(project_params), status: :updated
    end

    def show
        dev = find_dev
        # dev = Developer.first
        projects = dev.projects.all
        render json: projects, status: :ok
    end

    def index
       render json: Project.all
    end

    def destroy
        projects = Project.find_by(id: params[:id])
        projects.destroy
        render json: {}
    end

    private

    def project_params
        params.permit(:title, :url, :description)
    end

end
