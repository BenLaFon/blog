class CommentsController < ApplicationController
  before_action :set_post, except: :destroy
  def new
    @comment = Comment.new
    authorize @post
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.user_id = current_user.id
    @comment.save
    authorize @post
    redirect_to post_path(@post)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    @comment.destroy
    redirect_to post_path(@post)
    authorize @comment
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
