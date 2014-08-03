class PostsRepresenter
  attr_reader :decorator

  delegate :to_json, :as_json, to: :decorator

  def initialize(posts, options = {})
    @options = options
    authors = posts.map(&:author).uniq { |i| i.id }

    resource = Resource.new(posts: posts,
                            authors: authors,
                            links: links
                           )

    @decorator = PostsDecorator.new(resource)
  end

  protected

  attr_reader :options

  def links
    {
      'posts.author' => {
        href: "#{options[:base_url]}/authors/{posts.author}", type: 'authors'
      }
    }
  end

  class Resource < OpenStruct; end

  class PostsDecorator < Roar::Decorator
    include Roar::Representer::JSON

    hash :links

    collection :posts, class: Post, decorator: PostExtendedRepresenter

    nested :linked do
      collection :authors, class: Author, decorator: AuthorBaseRepresenter
    end
  end
end
