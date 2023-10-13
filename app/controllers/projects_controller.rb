class ProjectsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_project, only: [:show, :edit, :update, :destroy]
    
    def index
      if params[:a].present?
        p = params[:a]
        query = Project.where("title LIKE ? ", "%#{p}%")
        render json: query
      else
        @projects = Project.all
      end
    end
  
    def show
      # authorize @project, :show?
    end
  
    def new
      @project = Project.new
      @project.project_users.build
    end
  
    def create
      @project = Project.new(project_params)
      authorize @project
      @project.uid = current_user.id
      if @project.save
        redirect_to @project, notice: 'Project was successfully created.'
      end
    end
  
    def edit
      if current_user.id == @project.user_id
        else
          redirect_to projects_path, alert: 'You do not have permission to Edit this project.'
        end
    end
  
    def update
      authorize @project
      if @project.update(project_params)
        redirect_to @project, notice: 'Project was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      if current_user.id == @project.user_id
        @project.destroy
        redirect_to projects_path, notice: 'Project was successfully destroyed.'
      else
        redirect_to projects_path, alert: 'You do not have permission to destroy this project.'
      end
    end
  
    private
  
    def set_project
      @project = Project.find(params[:id])
    end
  
    def project_params
      params.require(:project).permit(:title, :description, project_users_attributes: [:id,:user_id,:_destroy])
    end
  end
  