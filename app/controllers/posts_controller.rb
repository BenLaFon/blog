class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    if params[:query].present?
      sql_query = 'title ILIKE :query OR content ILIKE :query'
      @posts = Post.where(sql_query, query: "%#{params[:query]}%")
    else
      @posts = Post.all.order(created_at: :desc)


    end
  end

  def new

    @post = Post.new
    authorize @post
  end

  def edit
    authorize @post
  end

  def update
    authorize @post
    @post.update(post_params)
    @post.save
    redirect_to post_path(@post)
  end

  def show

  end

  def destroy
    authorize @post
    @post.destroy
    redirect_to :root
  end

  def search
  end

  def create
    @post = Post.new(post_params)
    @post.date = Time.now
    @post.user = current_user
    authorize @post
    if @post.save
      redirect_to :root
    else
      render :new
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

end
