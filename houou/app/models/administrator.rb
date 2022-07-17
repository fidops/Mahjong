# == Schema Information
#
# Table name: administrators
#
#  id              :uuid             not null, primary key
#  password_digest :string
#  userid          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Administrator < ApplicationRecord
  self.implicit_order_column = 'created_at'

  has_secure_password

  has_one :access_token, dependent: :destroy

  validates :password, length: { minimum: 8 }
  validates :userid, presence: true
end
