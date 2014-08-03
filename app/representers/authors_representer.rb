class AuthorsRepresenter < Roar::Decorator
  include Representable::JSON::Collection

  self.representation_wrap = :authors

  items extend: AuthorBaseRepresenter, class: Author
end
