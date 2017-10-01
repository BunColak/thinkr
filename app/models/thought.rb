class Thought < ApplicationRecord
  belongs_to :user

  has_many :liked_relation, class_name: "Like",
                            foreign_key: "thought_id",
                            dependent: :destroy
  has_many :likes, through: :liked_relation, source: :liked

  default_scope -> {order(created_at: :desc)}
  validates :content, presence: true, length: {maximum: 140}
  validates :user_id, presence: true
  mount_uploader :picture, PictureUploader
  validate :picture_size

  private
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end
