require_relative '../spec_helper'
require 'rack/test'

describe 'Posts' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  let(:post) { Post.create(text: 'test') }

  describe 'GET /posts' do
    before do
      post

      get '/posts'
    end

    it 'returns 200 OK' do
      last_response.status.must_equal 200
    end

    it 'returns JSON' do
      result = JSON.parse(last_response.body)

      result.must_equal(
        'posts' => [{
          'id' => post.id,
          'text' => post.text,
          'created_at' => post.created_at.iso8601,
        }]
      )
    end
  end

  describe 'GET /posts/:id' do
    before do
      post

      get "/posts/#{post.id}"
    end

    it 'returns 200 OK' do
      last_response.status.must_equal 200
    end

    it 'returns JSON' do
      result = JSON.parse(last_response.body)

      result.must_equal(
        'posts' => {
          'id' => post.id,
          'text' => post.text,
          'created_at' => post.created_at.iso8601,
        }
      )
    end
  end
end
