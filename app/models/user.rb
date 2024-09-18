class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable, :recoverable,
         :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  validates :email, uniqueness: { case_sensitive: false }

  has_many :tasks, dependent: :destroy, class_name: 'Task'
end
