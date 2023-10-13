class Bug < ApplicationRecord
  belongs_to :project
  has_one_attached :image
 
  resourcify

  has_many :users, through: :roles, class_name: 'User', source: :users
  has_many :creators, -> { where(roles: {name: :creator}) }, through: :roles, class_name: 'User', source: :users
  has_many :editors, -> { where(roles: {name: :editor}) }, through: :roles, class_name: 'User', source: :users
end
