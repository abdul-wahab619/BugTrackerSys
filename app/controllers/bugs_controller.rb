class BugsController < ApplicationController
    before_action :set_bug, only: [:show, :edit, :update, :destroy]
  
    def index
      @bugs = Bug.all
    end
  
    def show
    end
  
    def assign_to_self
      @bug = Bug.find(params[:id])
      authorize @bug, :assign_to_self?
    end
  
    def resolve
      @bug = Bug.find(params[:id])
      authorize @bug, :resolve?
    end

    def new
      @bug = Bug.new
    end
  
    def create
      @project = Project.find(params[:project_id])
      if @bug = @project.bugs.create(bug_params)
        redirect_to @project, notice: 'Bug was successfully created.'
      end
    end
  
    def edit
    end
  
    def update
      if @bug.update(bug_params)
        redirect_to projects_path, notice: 'Bug was successfully updated.'
      else
        render :edit
      end
    end
  
    def destroy
      @bug.destroy
      redirect_to bugs_url, notice: 'Bug was successfully destroyed.'
    end
  
    private
  
    def set_bug
      @bug = Bug.find(params[:id])
    end
  
    def bug_params
      params.require(:bug).permit(:title, :deadline, :image, :bug_type, :status, :project_id)
    end
  end
  