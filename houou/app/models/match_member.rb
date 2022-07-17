# == Schema Information
#
# Table name: match_members
#
#  id         :uuid             not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  match_id   :uuid             not null
#  member_id  :uuid             not null
#
# Indexes
#
#  index_match_members_on_match_id   (match_id)
#  index_match_members_on_member_id  (member_id)
#
# Foreign Keys
#
#  fk_rails_...  (match_id => matches.id)
#  fk_rails_...  (member_id => members.id)
#
class MatchMember < ApplicationRecord
  belongs_to :match
  belongs_to :member
end
