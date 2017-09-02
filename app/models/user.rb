class User < ApplicationRecord
  before_save{self.email = email.downcase}
  EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :name, presence: true, length: {minimum: 3, maximum: 20}
  validates :email, presence: true, length: {minimum: 7, maximum: 30},
            format: {with: EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6, maximum: 30}
end
