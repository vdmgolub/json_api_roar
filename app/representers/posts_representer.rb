class PostsRepresenter < Roar::Decorator
  include Representable::JSON::Collection

  self.representation_wrap = :posts

  items extend: PostBaseRepresenter, class: Post
end
