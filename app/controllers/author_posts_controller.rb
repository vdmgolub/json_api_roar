class AuthorPostsController < ApplicationController
  def index
    posts = Post.where(author_id: params[:author_id])

    render json: AuthorPostsRepresenter.new(posts)
  end
end
