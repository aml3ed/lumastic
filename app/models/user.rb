class User < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :communities, through: :memberships
  has_many :discussions
  has_many :comments
  include Roleable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :display_name, uniqueness: true
end
