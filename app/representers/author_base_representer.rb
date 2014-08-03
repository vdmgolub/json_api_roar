class AuthorBaseRepresenter < Roar::Decorator
  include Roar::Representer::JSON

  property :id, render_nil: true
  property :name, render_nil: true
end
