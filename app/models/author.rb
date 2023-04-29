class Author < ApplicationRecord
  has_secure_password
  has_many :blogs
  has_many :posts, through: :blog
  has_many :posts
  has_many :blocked_users
  has_many :comments, as: :commentable
end
