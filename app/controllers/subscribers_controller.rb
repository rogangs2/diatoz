class SubscribersController < ApplicationController
  skip_before_action :logged_in?

  def new
    @person = Subscriber.new
  end

  def create
    @subscriber = Subscriber.new(subscriber_params)
    if @subscriber.save
      log_in @subscriber
      redirect_to  subscriber_dashboard_path
    else
      flash[:notice] = "unable to create subscriber"
      render :new
    end
  end

  def block_subscriber
    @record = BlockedUser.new(author_id: current_user.id, subscriber_id: params[:id])
    @record.save
    current_user.comments.where(subscriber_id: params[:id]).delete_all
    @posts_id = Post.where(author_id: params[:id]).pluck(:id)
    Comment.where(subscriber_id: params[:id]).where(commentable_type: 'Post').where(commentable_id: @posts_id).delete_all
    redirect_to controller: 'comments', action: 'comments_need_approval' and return
  end

  private
    def subscriber_params
      params.require(:subscriber).permit(:name, :email, :password)
    end
end
