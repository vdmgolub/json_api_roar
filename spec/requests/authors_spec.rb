require_relative '../spec_helper'
require 'rack/test'

describe 'Authors' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  let(:author) { Author.create(name: 'John Doe') }

  describe 'GET /authors' do
    before do
      author

      get '/authors'
    end

    it 'returns 200 OK' do
      last_response.status.must_equal 200
    end

    it 'returns JSON' do
      result = JSON.parse(last_response.body)

      result.must_equal(
        'authors' => [{
          'id' => author.id,
          'name' => author.name,
        }]
      )
    end
  end

  describe 'GET /authors/:id' do
    before do
      author

      get "/authors/#{author.id}"
    end

    it 'returns 200 OK' do
      last_response.status.must_equal 200
    end

    it 'returns JSON' do
      result = JSON.parse(last_response.body)

      result.must_equal(
        'authors' => {
          'id' => author.id,
          'name' => author.name,
        }
      )
    end
  end
end
