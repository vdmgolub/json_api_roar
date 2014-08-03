10.times do |index|
  Post.create(text: "lorem ipsum #{index}")
end
