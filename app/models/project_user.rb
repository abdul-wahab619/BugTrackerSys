class ProjectUser < ApplicationRecord
  belongs_to :project
  belongs_to :user

  enum user_type: { developer: 'developer', manager: 'manager', qa: 'qa' }
end
