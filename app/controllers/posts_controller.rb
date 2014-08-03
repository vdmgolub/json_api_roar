class PostsController < ApplicationController
  def index
    posts = Post.all
    render json: PostsRepresenter.new(posts, serialization_options)
  end

  def show
    post = Post.find(params[:id])

    render json: PostRepresenter.new(post, serialization_options)
  end
end
