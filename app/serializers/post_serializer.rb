class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :tags, :likes, :dislikes, :views, :created_at, :username
  belongs_to :user
  def username
    object.user.username
  end
  
end
