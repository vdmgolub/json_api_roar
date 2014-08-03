Post.delete_all
Author.delete_all

['Jay', 'Silent Bob'].each do |name|
  author = Author.create(name: name)

  10.times do |index|
    Post.create(text: "lorem ipsum #{index}", author: author)
  end
end
