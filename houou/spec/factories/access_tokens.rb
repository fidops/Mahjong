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
FactoryBot.define do
  factory :access_token do
    token
    auth_token
  end
end
