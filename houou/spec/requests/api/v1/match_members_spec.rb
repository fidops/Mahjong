RSpec.describe "Api::V1::MatchMembers", type: :request do
  let!(:administrator) { create(:administrator) }
  let!(:token) { administrator.create_access_token!.to_jwt }
  let(:headers) do
    {
      Authorization: "Bearer #{token}",
      'Content-Type': 'application/json',
      Accept: 'application/json'
    }
  end

  describe 'GET /api/v1/matches/:match_id/members' do
    let!(:match) { create(:match) }
    let(:match_id) { match.id }

    subject { get api_v1_match_members_url(match_id), headers: }

    context 'Correct - 200' do
      context 'when no members exist' do
        it 'returns empty array response' do
          subject

          expect(json).to be_a(Array)
          expect(json.length).to eq(0)
        end

        it { is_expected_response.to have_http_status(200) }
      end

      context 'when 10 members exist' do
        let(:members_count) { 10 }
        let!(:members) { create_list(:member, members_count, match:) }

        it 'returns response that array of members' do
          subject

          expect(json).to be_a(Array)
          expect(json.length).to eq(members_count)
          expect(unsymbolized_json).to eq(members.as_json)
        end

        it { is_expected_response.to have_http_status(200) }
      end
    end
    context 'Illegal - 404' do
      context 'when specified match does not exist' do
        let(:match_id) { 'invalid' }

        it { is_expected_response.to have_http_status(404) }
      end
    end

    context 'Illegal - 401' do
      context 'when no token specified' do
        let(:token) { '' }

        it { is_expected_response.to have_http_status(401) }
      end
    end
  end

  describe 'POST /api/v1/matches/:match_id/members' do
    let(:member) { create(:member) }
    let(:match) { create(:match) }
    let(:member_id) { member.id }
    let(:match_id) { match.id }
    let(:params) do
      {
        match_id:,
        member_id:
      }.to_json
    end

    subject { post api_v1_match_members_url(match_id), headers:, params: }

    context 'Correct - 201' do
      context 'when request with valid params' do
        it { is_expected_response.to have_http_status(201) }
      end
    end

    context 'Illegal - 401' do
      context 'when no token specified' do
        let(:token) { '' }

        it { is_expected_response.to have_http_status(401) }
      end
    end

    context 'Illegal - 404' do
      context 'when specified match does not specified' do
        let(:match_id) { nil }

        it { is_expected_response.to have_http_status(404) }
      end

      context 'when specified member does not specified' do
        let(:member_id) { nil }

        it { is_expected_response.to have_http_status(404) }
      end
    end
  end
end
