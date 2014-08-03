class AuthorsController < ApplicationController
  def index
    authors = Author.all

    render json: AuthorsRepresenter.new(authors)
  end

  def show
    author = Author.find(params[:id])

    render json: AuthorRepresenter.new(author)
  end
end
