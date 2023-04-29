class Post < ApplicationRecord
  belongs_to :blog
  belongs_to :author
  has_many :comments, as: :commentable
end
