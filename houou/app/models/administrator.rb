class Administrator < ApplicationRecord
  has_secure_password

  has_one :access_token, dependent: :destroy

  validates :password, length: { minimum: 8 }
  validates :userid, presence: true
end
