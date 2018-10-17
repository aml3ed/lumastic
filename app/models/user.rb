class User < ApplicationRecord
  has_and_belongs_to_many :communities
  include Roleable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :display_name, uniqueness: true
end
