class User < ApplicationRecord
  rolify
  has_secure_password

  validates :email, uniqueness: true
end
