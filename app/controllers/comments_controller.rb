class CommentsController < ApplicationController
  def index
    @post_id = params[:post_id]
    @comments = Post.find(params[:post_id]).comments
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new
    @comment.subscriber_id = current_user.id
    @comment.content = params[:comment][:content]
    @comment.approved = false
    CreateCommentJob.set(wait: 1.minutes).perform_later(@comment.serializable_hash)
    redirect_to action: 'index', post_id: params[:post_id] and return
  end

  def comments_need_approval
    @comments_on_author = current_user.comments
    @posts_comments_data = Post.includes(:comments).where(author_id: current_user.id)
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(approved: true)
      redirect_to action: 'comments_need_approval' and return
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to action: 'comments_need_approval' and return
    end
  end

  def comment_on_author
    @author = Author.find(params[:author_id])
    @comment = @author.comments.new
    @comment.subscriber_id = current_user.id
    @comment.content = params[:comment][:content]
    @comment.approved = false
    CreateCommentJob.set(wait: 1.minutes).perform_later(@comment.serializable_hash)
    redirect_to author_path(params[:author_id]) and return
  end
end
