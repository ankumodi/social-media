json.posts @posts do |post|
  json.id post.id
  json.title post.title
  json.body post.body
  json.tags post.tags
  json.likes post.likes
  json.dislikes post.dislikes
  json.views post.views
  json.created_at post.created_at

  json.user do
    json.id post.user.id
    json.username post.user.username
  end
end