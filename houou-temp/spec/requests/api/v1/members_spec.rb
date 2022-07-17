RSpec.describe 'Api::V1::Members', type: :request do
  let!(:administrator) { create(:administrator) }
  let!(:token) { administrator.create_access_token!.to_jwt }
  let(:headers) do
    {
      Authorization: "Bearer #{token}",
      'Content-Type': 'application/json',
      Accept: 'application/json'
    }
  end

  describe 'GET /api/v1/members' do
    subject { get api_v1_members_url, headers: }

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
        let!(:members) { create_list(:member, members_count) }

        it 'returns response that array of members' do
          subject

          expect(json).to be_a(Array)
          expect(json.length).to eq(members_count)
          expect(unsymbolized_json).to eq(members.as_json)
        end

        it { is_expected_response.to have_http_status(200) }
      end
    end

    context 'Illegal - 401' do
      context 'when no token specified' do
        let(:token) { '' }

        it { is_expected_response.to have_http_status(401) }
      end
    end
  end

  describe 'GET /api/v1/members/:id' do
    let!(:member) { create(:member) }
    let(:member_id) { member.id }

    subject { get api_v1_member_url(member_id), headers: }

    context 'Correct - 200' do
      context 'when member exists' do
        it 'returns response for member' do
          subject

          expect(json[:name]).to eq(member.name)
          expect(json[:discord_id]).to eq(member.discord_id)
        end

        it { is_expected_response.to have_http_status(200) }
      end
    end

    context 'Illegal - 401' do
      context 'when no token specified' do
        let(:token) { '' }

        it { is_expected_response.to have_http_status(401) }
      end
    end

    context 'Illegal - 404' do
      context 'when specified member does not exist' do
        let(:member_id) { -1 }

        it { is_expected_response.to have_http_status(404) }
      end
    end
  end

  describe 'POST /api/v1/members' do
    let(:name) { Faker::Name.name }
    let(:discord_id) { Faker::Number.number(digits: 18).to_s }
    let(:params) do
      { name:, discord_id: }.to_json
    end

    subject { post api_v1_members_url, headers:, params: }

    context 'Correct - 201' do
      context 'when request with valid params' do
        it 'returns created resource' do
          subject

          expect(json[:name]).to eq(name)
          expect(json[:discord_id]).to eq(discord_id)
        end

        it { is_expected_response.to have_http_status(201) }
      end
    end

    context 'Illegal - 401' do
      context 'when no token specified' do
        let(:token) { '' }
        it { is_expected_response.to have_http_status(401) }
      end
    end

    context 'Illegal - 422' do
      context 'when name does not specified' do
        let(:name) { nil }

        it { is_expected_response.to have_http_status(422) }
      end
    end
  end

  describe 'PATCH/PUT /api/v1/members/:id' do
    let!(:member) { create(:member) }
    let(:member_id) { member.id }

    let(:name) { Faker::Name.name }
    let(:discord_id) { Faker::Number.number(digits: 18).to_s }
    let(:params) do
      { name:, discord_id: }.to_json
    end

    subject { put api_v1_member_url(member_id), headers:, params: }

    context 'Correct - 200' do
      context 'when request with valid params' do
        it 'returns updated resource' do
          subject

          expect(json[:name]).to eq(name)
          expect(json[:discord_id]).to eq(discord_id)
        end

        it { is_expected_response.to have_http_status(200) }
      end
    end

    context 'Illegal - 401' do
      context 'when no token specified' do
        let(:token) { '' }

        it { is_expected_response.to have_http_status(401) }
      end
    end

    context 'Illegal - 422' do
      context 'when name does not specified' do
        let(:name) { nil }

        it { is_expected_response.to have_http_status(422) }
      end
    end
  end

  describe 'DELETE /api/v1/members/:id' do
    let!(:member) { create(:member) }
    let(:member_id) { member.id }

    subject { delete api_v1_member_url(member_id), headers: }

    context 'Correct - 200' do
      context 'when specified member exists' do
        it { is_expected_response.to have_http_status(204) }
      end
    end

    context 'Illegal - 401' do
      context 'when no token specified' do
        let(:token) { '' }

        it { is_expected_response.to have_http_status(401) }
      end
    end
  end
end
