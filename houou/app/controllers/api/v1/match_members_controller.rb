class Api::V1::MatchMembersController < ApplicationController
  before_action :set_match

  def index
    @members = @match.members
  end

  def create
    member = Member.find(params[:member_id])
    @match.members.push(member)
    head :created
  end

  private

  def set_match
    @match = Match.find(params[:match_id])
  end
end
