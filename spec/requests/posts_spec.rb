require_relative '../spec_helper'
require 'rack/test'

describe 'Posts' do
  include Rack::Test::Methods

  def app
    Rails.application
  end

  let(:author) { Author.create(name: 'John Doe') }
  let(:post) { Post.create(text: 'test', author: author) }

  describe 'GET /posts' do
    before do
      post

      get '/posts'
      @result = JSON.parse(last_response.body)
    end

    it 'returns 200 OK' do
      last_response.status.must_equal 200
    end

    it 'returns JSON data' do
      @result['posts'].must_equal(
        [{
          'id' => post.id,
          'text' => post.text,
          'created_at' => post.created_at.iso8601,
          'links' => { 'author' => post.author.id },
        }]
      )
    end

    it 'returns links' do
      @result['links'].must_equal(
        'posts.author' => {
          'href' => 'http://example.org/authors/{posts.author}',
          'type' => 'authors'
        }
      )
    end

    it 'returns linked authors' do
      @result['linked'].must_equal(
        'authors' => [{
          'id' => author.id,
          'name' => author.name,
        }]
      )
    end
  end

  describe 'GET /posts/:id' do
    before do
      post

      get "/posts/#{post.id}"
      @result = JSON.parse(last_response.body)
    end

    it 'returns 200 OK' do
      last_response.status.must_equal 200
    end

    it 'returns JSON data' do
      @result['posts'].must_equal(
        {
          'id' => post.id,
          'text' => post.text,
          'created_at' => post.created_at.iso8601,
          'links' => { 'author' => post.author.id },
        }
      )
    end

    it 'returns links' do
      @result['links'].must_equal(
        'posts.author' => {
          'href' => 'http://example.org/authors/{posts.author}',
          'type' => 'authors'
        }
      )
    end

    it 'returns linked authors' do
      @result['linked'].must_equal(
        'authors' => [{
          'id' => author.id,
          'name' => author.name,
        }]
      )
    end
  end
end
