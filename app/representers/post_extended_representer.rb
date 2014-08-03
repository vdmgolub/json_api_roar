class PostExtendedRepresenter < PostBaseRepresenter
  property :links, exec_context: :decorator

  def links
    {
      author: represented.author_id,
    }
  end
end
