# == Schema Information
#
# Table name: access_tokens
#
#  id               :uuid             not null, primary key
#  auth_token       :string
#  token            :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  administrator_id :bigint
#
# Indexes
#
#  index_access_tokens_on_administrator_id  (administrator_id)
#  index_access_tokens_on_auth_token        (auth_token) UNIQUE
#  index_access_tokens_on_token             (token) UNIQUE
#
require 'jwt'

class AccessToken < ApplicationRecord
  has_secure_token :token, length: 64
  has_secure_token :auth_token, length: 64

  belongs_to :administrator

  def self.authenticate_by(jwt)
    return false if jwt.blank?

    payload, _header =
      JWT.decode(jwt, Rails.application.credentials.secret_key_base, true, { algorithm: 'HS512' })
    return false unless payload['token'] && payload['auth_token'] && payload['administrator_id']

    find_by(administrator_id: payload['administrator_id'], token: payload['token'], auth_token: payload['auth_token'])
  end

  def to_jwt
    payload = { administrator_id:, token:, auth_token: }
    JWT.encode(payload, Rails.application.credentials.secret_key_base, 'HS512')
  end
end
