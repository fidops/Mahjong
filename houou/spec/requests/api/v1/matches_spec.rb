RSpec.describe 'Api::V1::Matches', type: :request do
  let!(:administrator) { create(:administrator) }
  let!(:token) { administrator.create_access_token!.to_jwt }
  let(:headers) do
    {
      Authorization: "Bearer #{token}",
      'Content-Type': 'application/json',
      Accept: 'application/json'
    }
  end

  describe 'GET /api/v1/matches' do
    subject { get api_v1_matches_url, headers: }

    context 'Correct - 200' do
      context 'when no matches exist' do
        it 'returns empty array response' do
          subject

          expect(json).to be_a(Array)
          expect(json.length).to eq(0)
        end

        it { is_expected_response.to have_http_status(200) }
      end

      context 'when 10 matches exist' do
        let(:matches_count) { 10 }
        let!(:matches) { create_list(:match, matches_count) }

        it 'returns response that array of matches' do
          subject

          expect(json).to be_a(Array)
          expect(json.length).to eq(matches_count)
          expect(unsymbolized_json).to eq(matches.as_json)
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

  describe 'GET /api/v1/matches/:id' do
    let!(:match) { create(:match) }
    let(:match_id) { match.id }

    subject { get api_v1_match_url(match_id), headers: }

    context 'Correct - 200' do
      context 'when match exists' do
        it 'returns response for match' do
          subject

          expect(json[:name]).to eq(match.name)
          expect(json[:jansou_id]).to eq(match.jansou_id)
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
      context 'when specified match does not exist' do
        let(:match_id) { -1 }

        it { is_expected_response.to have_http_status(404) }
      end
    end
  end

  describe 'POST /api/v1/matches' do
    let(:name) { Faker::Name.name }
    let(:jansou) { create(:jansou) }
    let(:jansou_id) { jansou.id }
    let(:params) do
      { name:, jansou_id: }.to_json
    end

    subject { post api_v1_matches_url, headers:, params: }

    context 'Correct - 201' do
      context 'when request with valid params' do
        it 'returns created resource' do
          subject

          expect(json[:name]).to eq(name)
          expect(json[:jansou_id]).to eq(jansou_id)
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

      context 'when jansou_id does not specified' do
        let(:jansou_id) { nil }

        it { is_expected_response.to have_http_status(422) }
      end
    end
  end

  describe 'PATCH/PUT /api/v1/matches/:id' do
    let!(:match) { create(:match) }
    let(:match_id) { match.id }

    let(:name) { Faker::Name.name }
    let(:jansou) { create(:jansou) }
    let(:jansou_id) { jansou.id }
    let(:params) do
      { name:, jansou_id: }.to_json
    end

    subject { put api_v1_match_url(match_id), headers:, params: }

    context 'Correct - 200' do
      context 'when request with valid params' do
        it 'returns updated resource' do
          subject

          expect(json[:name]).to eq(name)
          expect(json[:jansou_id]).to eq(jansou_id)
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

      context 'when jansou_id does not specified' do
        let(:jansou_id) { nil }

        it { is_expected_response.to have_http_status(422) }
      end
    end
  end

  describe 'DELETE /api/v1/matches/:id' do
    let!(:match) { create(:match) }
    let(:match_id) { match.id }

    subject { delete api_v1_match_url(match_id), headers: }

    context 'Correct - 200' do
      context 'when specified match exists' do
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
