class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :project

  def initialize(user, project)
    @user = user
    @project = project
  end

  def create?
    user.Manager?
  end

  def update?
    user.user_type=="Manager" && user == project.user
  end

  def destroy?
    user.manager? && user == project.user
  end

  def show?
    user.developer? && user.projects.include?(@project)
  end

  
  # def index?
  #   user.developer?
  # end
end
