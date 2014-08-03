class PostRepresenter
  attr_reader :decorator

  delegate :to_json, :as_json, to: :decorator

  def initialize(post, options = {})
    @options = options

    resource = Resource.new(posts: post,
                            authors: [post.author],
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

    property :posts, class: Post, decorator: PostExtendedRepresenter

    nested :linked do
      collection :authors, class: Author, decorator: AuthorBaseRepresenter
    end
  end
end
