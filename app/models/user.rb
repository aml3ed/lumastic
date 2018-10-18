class User < ApplicationRecord
  include Roleable

  # Relationships
  has_many :communities, through: :community_users
  has_many :courses

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :display_name, uniqueness: true
end
