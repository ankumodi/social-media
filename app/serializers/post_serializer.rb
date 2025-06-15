class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :likes, :dislikes, :views, :created_at, :tags
  belongs_to :user
  has_many :tags
  def tags
    object.tags.map(&:name)
  end
end
