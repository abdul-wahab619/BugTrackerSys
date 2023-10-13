class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :project_users,dependent: :destroy
  has_many :projects,through: :project_users,dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :name, presence: true
         validates :user_type, presence: true

         enum role: { Manager: 0, Developer: 1, QA: 2 }

         has_many :creator_posts, -> { where(roles: {name: :creator}) }, through: :roles, source: :resource, source_type: :Bug
         has_many :editor_posts, -> { where(roles: {name: :editor}) }, through: :roles, source: :resource, source_type: :Bug
end
