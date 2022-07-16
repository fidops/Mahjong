json.extract! member, :id, :name, :discord_id, :created_at, :updated_at
json.url api_v1_member_url(member, format: :json)
