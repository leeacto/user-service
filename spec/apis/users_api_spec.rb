require 'spec_helper'

def app
  ApplicationApi
end

describe UsersApi do
  include Rack::Test::Methods

  describe 'get /:id' do
    context 'with valid hashed_screen_name' do
      it 'returns the correct user' do
        u = FactoryGirl.create(:user)
        get "/users/#{u.hashed_screen_name}"
        expect(parsed_response[:data].id).to eq u.id.to_s
      end
    end

    context 'with invalid hashed_screen_name' do
      it 'returns User Not Found error' do
        get "/users/0"
        expected_error = Hashie::Mash.new({ code: 'api_error', message: 'User Not Found' })
        expect(parsed_response[:error]).to eq expected_error
        expect(last_response.status).to eq 404
      end
    end
  end

  describe 'post /' do
    context 'with valid attributes' do
      it 'Creates a new User' do
        params = { first_name: 'Jay', last_name: 'Bob', email_address: 'jay@bob.com' }
        expect{ post "/users", params }.to change{ User.count }.by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a user when missing first_name' do
        params = { last_name: 'Bob', email_address: 'jay@bob.com' }
        expected_error = Hashie::Mash.new({ code: 'api_error', message: 'first_name is missing' })
        expect{ post "/users", params }.not_to change{ User.count }
        expect(last_response.status).to eq 400
        expect(parsed_response[:error]).to eq expected_error
      end

      it 'does not create a user when email is taken' do
        u = FactoryGirl.create(:user)
        params = { first_name: 'Jay', last_name: 'Bob', email_address: u.email_address }
        expected_error = Hashie::Mash.new({ code: 'api_error', message: 'Email address has already been taken' })
        expect{ post "/users", params }.not_to change{ User.count }
        expect(last_response.status).to eq 400
        expect(parsed_response[:error]).to eq expected_error
      end
    end
  end

end
