class Comment < ApplicationRecord
  belongs_to :discussion, optional: true
  belongs_to :lesson, optional: true
  belongs_to :user
  belongs_to :parent, class_name: "Comment", optional: true
  has_many   :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
end
