class PostsController < ApplicationController
  skip_before_action :authenticate_user, only: [:index]
  before_action :set_post, only: [:show, :update, :destroy]
  def index
   #@posts = Post.all
   # render json: {posts: @posts}
#@posts = Post.includes(:user).first
#render json: {post: @posts}
#render json: { posts: ActiveModelSerializers::SerializableResource.new(@posts, include: [:user]).serializable_hash }
#@posts = Post.includes(:user).all
# Explicit render is optional since Rails will auto-render the jbuilder template
#render :index
    @posts = Post.all.includes(:user)
    render json: @posts, each_serializer: PostSerializer
  end

  def show
    render json: {post: @post}
  end

  def create
    @post = Post.new(post_params)
    puts 'AAAAA'
    puts @current_user
    @post.user = @current_user
    puts @current_user.id
    puts @post.user_id
    if @post.save
      render json: @post, status: :created, location: @post
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
      params.require(:post).permit(:title, :body, :tags, :likes, :dislikes, :views)
    end
    
end