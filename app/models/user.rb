class User < ApplicationRecord
  has_one_attached :avatar
  has_many :memberships, dependent: :delete_all
  has_many :communities, through: :memberships
  has_many :lessons, dependent: :destroy
  has_many :discussions
  has_many :comments
  has_many :views
  include Roleable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :display_name, uniqueness: true
  validates :avatar, content_type: { in: ['image/png', 'image/jpg', 'image/jpeg'], message: "must be JPEG or PNG"}, size: { less_than: 2.megabytes , message: 'must be smaller than 2 MB' }

  # Helpers
  def get_avatar(size=40)
    if self.avatar.attached? && self.avatar.attachment.blob.present? && self.avatar.attachment.blob.persisted?
      self.avatar.variant(resize: "#{size}x#{size}!")
    else
      "default_prof_pic.jpg"
    end
  end

end
