class Subscriber < ApplicationRecord
  has_secure_password
  has_many :comments
end
