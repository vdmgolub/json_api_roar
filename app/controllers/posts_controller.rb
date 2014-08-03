class PostsController < ApplicationController
  def index
    posts = Post.all
    render json: PostsRepresenter.new(posts)
  end

  def show
    post = Post.find(params[:id])

    render json: PostRepresenter.new(post)
  end
end
