class BugPolicy < ApplicationPolicy
  attr_reader :user, :bug

  def initialize(user, bug)
    @user = user
    @bug = bug
  end

  def hide_tag?
    user.user_type == "QA"
  end
  def create?
      user.user_type=="QA"
  end

  def assign_to_self?
    user.developer? && user.projects.include?(@bug.project)
  end

  def resolve?
    user.developer? && user == @bug.developer
  end

  def destroy?
    false
  end

  def update?
    user.user_type=="Developer"
 end
 
end