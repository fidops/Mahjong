RSpec.describe 'Api::V1::Games', type: :request do
  let!(:administrator) { create(:administrator) }
  let!(:token) { administrator.create_access_token!.to_jwt }
  let(:headers) do
    {
      Authorization: "Bearer #{token}",
      'Content-Type': 'application/json',
      Accept: 'application/json'
    }
  end

  describe 'GET /api/v1/games' do
    subject { get api_v1_games_url, headers: }

    context 'Correct - 200' do
      context 'when no games exist' do
        it 'returns empty array response' do
          subject
          expect(json).to be_a(Array)
          expect(json.length).to eq(0)
        end

        it { is_expected_response.to have_http_status(200) }
      end

      context 'when 10 games exist' do
        let(:games_count) { 10 }
        let!(:games) { create_list(:game, games_count) }

        it 'returns response that array of games' do
          subject

          expect(json).to be_a(Array)
          expect(json.length).to eq(games_count)
          expect(unsymbolized_json).to eq(games.as_json)
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

  describe 'PATCH/PUT /api/v1/games/:id' do
    # create saved game
    let!(:game) { create(:game) }
    let(:game_id) { game.id }

    # updated game
    let(:score_min) { 0 }
    let(:score_max) { 50_000 }
    let(:members) { create_list(:member, 4) }
    let(:east_id) { members.first.id }
    let(:south_id) { members.second.id }
    let(:west_id) { members.third.id }
    let(:north_id) { members.fourth.id }
    let(:east_score) { Faker::Number.rand_in_range(score_min, score_max) }
    let(:south_score) { Faker::Number.rand_in_range(score_min, score_max) }
    let(:west_score) { Faker::Number.rand_in_range(score_min, score_max) }
    let(:north_score) { Faker::Number.rand_in_range(score_min, score_max) }
    let(:match_id) { game.match.id }
    let(:params) do
      {
        east_id:,
        south_id:,
        west_id:,
        north_id:,
        east_score:,
        south_score:,
        west_score:,
        north_score:,
        match_id:
      }.to_json
    end

    subject { put api_v1_game_url(game_id), headers:, params: }

    context 'Correct - 200' do
      context 'when request with valid params' do
        it 'returns updated resource' do
          subject

          expect(json[:east_id]).to eq(east_id)
          expect(json[:south_id]).to eq(south_id)
          expect(json[:west_id]).to eq(west_id)
          expect(json[:north_id]).to eq(north_id)
          expect(json[:east_score]).to eq(east_score)
          expect(json[:south_score]).to eq(south_score)
          expect(json[:west_score]).to eq(west_score)
          expect(json[:north_score]).to eq(north_score)
          expect(json[:match_id]).to eq(match_id)
        end

        it { is_expected_response.to have_http_status(200) }
      end

      context 'when request for sanma' do
        let(:north_id) { nil }
        let(:north_score) { nil }

        it 'returns updated resource' do
          subject

          expect(json[:east_id]).to eq(east_id)
          expect(json[:south_id]).to eq(south_id)
          expect(json[:west_id]).to eq(west_id)
          expect(json[:north_id]).to eq(north_id)
          expect(json[:east_score]).to eq(east_score)
          expect(json[:south_score]).to eq(south_score)
          expect(json[:west_score]).to eq(west_score)
          expect(json[:north_score]).to eq(north_score)
          expect(json[:match_id]).to eq(match_id)
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
      context 'when east_id does not specified' do
        let(:east_id) { nil }

        it { is_expected_response.to have_http_status(422) }
      end

      context 'when south_id does not specified' do
        let(:south_id) { nil }

        it { is_expected_response.to have_http_status(422) }
      end

      context 'when west_id does not specified' do
        let(:west_id) { nil }

        it { is_expected_response.to have_http_status(422) }
      end

      context 'when east_score does not specified' do
        let(:east_score) { nil }

        it { is_expected_response.to have_http_status(422) }
      end

      context 'when south_score does not specified' do
        let(:south_score) { nil }

        it { is_expected_response.to have_http_status(422) }
      end

      context 'when west_score does not specified' do
        let(:west_score) { nil }

        it { is_expected_response.to have_http_status(422) }
      end
    end
  end

  describe 'DELETE /api/v1/games/:id' do
    let!(:game) { create(:game) }
    let(:game_id) { game.id }

    subject { delete api_v1_game_url(game_id), headers: }

    context 'Correct - 200' do
      context 'when specified game exists' do
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
