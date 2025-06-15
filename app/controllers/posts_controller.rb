class PostsController < ApplicationController
  skip_before_action :authenticate_user, only: [:index]
  before_action :set_post, only: [:show, :update, :destroy]
 
  def index
    posts = Post.all
    render json: ActiveModelSerializers::SerializableResource.new(posts, each_serializer: PostSerializer).as_json
  end
 
  def show
    render json: {post: @post}
  end

  def create
    puts post_params
    @post = Post.new(post_params.except(:tags))
    puts 'AAAAA'
    puts @current_user
    @post.user = @current_user
    puts @current_user.id
    puts @post.user_id
    if @post.save
      attach_tags(@post, post_params[:tags])
      render json: ActiveModelSerializers::SerializableResource.new(@post, each_serializer: PostSerializer).as_json, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /groups/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      render json: { message: "Post deleted successfully" }, status: :ok
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :body, :likes, :dislikes, :views, tags: [])
    end

    def attach_tags(post, tag_names)
      return unless tag_names
  
      tag_records = tag_names.map do |tag_name|
        Tag.find_or_create_by(name: tag_name.strip.downcase)
      end
  
      post.tags = tag_records
    end
   
    
end