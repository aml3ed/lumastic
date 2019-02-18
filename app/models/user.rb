class User < ApplicationRecord
  has_one_attached :avatar
  has_many :memberships, dependent: :delete_all
  has_many :communities, through: :memberships
  has_many :lessons, dependent: :destroy
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
  validate :avatar_type

  # Helpers
  def get_avatar(size=40)
    if self.avatar.attached?
      self.avatar.variant(resize: "#{size}x#{size}!")
    else
      "default_prof_pic.jpg"
    end
  end

  private

  def avatar_type
    if avatar.attached? && !avatar.content_type.in?(%w(image/jpeg image/jpg image/png))
      avatar.purge
      errors.add(:avatar, " must be a JPEG or PNG.")
    end
  end
end
