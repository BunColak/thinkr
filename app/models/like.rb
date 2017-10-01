class Like < ApplicationRecord
  belongs_to :thought
  belongs_to :liked, class_name: "User"

  validates :thought_id, presence: true
  validates :liked_id, presence: true
end
