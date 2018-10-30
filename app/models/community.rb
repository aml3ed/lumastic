class Community < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships
  has_many :discussions
  has_many :courses

  def is_user_member(current_user)
    if current_user
      return self.users.include?(current_user)
    end
    return false
  end

end
