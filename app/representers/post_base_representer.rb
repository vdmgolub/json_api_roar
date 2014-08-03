class PostBaseRepresenter < Roar::Decorator
  include Roar::Representer::JSON

  property :id, render_nil: true
  property :text, render_nil: true
  property :created_at, exec_context: :decorator, render_nil: true

  def created_at
    represented.created_at.try(:iso8601)
  end
end
