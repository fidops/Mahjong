RSpec.describe 'Api::V1::Jansous', type: :request do
  let!(:administrator) { create(:administrator) }
  let!(:token) { administrator.create_access_token!.to_jwt }
  let(:headers) do
    {
      Authorization: "Bearer #{token}",
      'Content-Type': 'application/json',
      Accept: 'application/json'
    }
  end

  describe 'GET /api/v1/jansous' do
    subject { get api_v1_jansous_url, headers: }

    context 'Correct - 200' do
      context 'when no jansous exist' do
        it 'returns empty array response' do
          subject

          expect(json).to be_a(Array)
          expect(json.length).to eq(0)
        end

        it { is_expected_response.to have_http_status(200) }
      end

      context 'when 10 jansous exist' do
        let(:jansous_count) { 10 }
        let!(:jansous) { create_list(:jansou, jansous_count) }

        it 'returns response that array of jansous' do
          subject

          expect(json).to be_a(Array)
          expect(json.length).to eq(jansous_count)
          expect(unsymbolized_json).to eq(jansous.as_json)
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

  describe 'GET /api/v1/jansous/:id' do
    let!(:jansou) { create(:jansou) }
    let(:jansou_id) { jansou.id }

    subject { get api_v1_jansou_url(jansou_id), headers: }

    context 'Correct - 200' do
      context 'when jansou exists' do
        it 'returns response for jansou' do
          subject

          expect(json[:name]).to eq(jansou.name)
          expect(json[:google_map_url]).to eq(jansou.google_map_url)
          expect(json[:address]).to eq(jansou.address)
          expect(json[:note]).to eq(jansou.note)
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
      context 'when specified jansou does not exist' do
        let(:jansou_id) { -1 }

        it { is_expected_response.to have_http_status(404) }
      end
    end
  end

  describe 'POST /api/v1/jansous' do
    let(:name) { Faker::Name.name }
    let(:google_map_url) { Faker::Internet.url }
    let(:address) { Faker::Address.full_address }
    let(:note) { Faker::Lorem.sentence }
    let(:params) do
      { name:, google_map_url:, address:, note: }.to_json
    end

    subject { post api_v1_jansous_url, headers:, params: }

    context 'Correct - 201' do
      context 'when request with valid params' do
        it 'returns created resource' do
          subject

          expect(json[:name]).to eq(name)
          expect(json[:google_map_url]).to eq(google_map_url)
          expect(json[:address]).to eq(address)
          expect(json[:note]).to eq(note)
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

  describe 'PATCH/PUT /api/v1/jansous/:id' do
    let!(:jansou) { create(:jansou) }
    let(:jansou_id) { jansou.id }

    let(:name) { Faker::Name.name }
    let(:google_map_url) { Faker::Internet.url }
    let(:address) { Faker::Address.full_address }
    let(:note) { Faker::Lorem.sentence }
    let(:params) do
      { name:, google_map_url:, address:, note: }.to_json
    end

    subject { put api_v1_jansou_url(jansou_id), headers:, params: }

    context 'Correct - 200' do
      context 'when request with valid params' do
        it 'returns updated resource' do
          subject

          expect(json[:name]).to eq(name)
          expect(json[:google_map_url]).to eq(google_map_url)
          expect(json[:address]).to eq(address)
          expect(json[:note]).to eq(note)
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

  describe 'DELETE /api/v1/jansous/:id' do
    let!(:jansou) { create(:jansou) }
    let(:jansou_id) { jansou.id }

    subject { delete api_v1_jansou_url(jansou_id), headers: }

    context 'Correct - 200' do
      context 'when specified jansou exists' do
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
