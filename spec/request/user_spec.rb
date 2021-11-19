RSpec.describe 'User', type: :request do
  describe "post /api/v1/users" do

    it 'returns success' do
      post "/api/v1/users", params: { first_name: 'Quim', last_name: 'Barreiros', admin: true }
      #created
      expect(response.status).to eq(201)
      # ....

    end

    it 'returns error' do
      post "/api/v1/users", params: { first_name: '', last_name: '', admin: true }

      expect(response.status).to eq(400)
      # ....
    end
  end

  describe "get /api/v1/users/1" do

    it 'returns success' do
      get "/api/v1/users/1"

      expect(response.status).to eq(200)
      # ....

    end

    it 'returns error' do
      get "/api/v1/users/1"

      expect(response.status).to eq(404)
      # ....
    end
  end


  describe "get /api/v1/users" do

    it 'returns success' do
      get "/api/v1/users"

      expect(response.status).to eq(200)
      # ....

    end
  end
end