class PostsController < ApplicationController

  def index
    if current_user.author?
      @posts = current_user.posts.where(blog_id: params[:blog_id])
      @blog = Blog.find(params[:blog_id])
    else
      @posts = Post.where(blog_id: params[:blog_id])
    end
  end

  def new
    @post = Post.new
    @blog_id = params[:blog_id]
    @author_id = session[:user_id]
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to action: 'index', blog_id: params[:blog_id]  and return
    else
      render :new
    end
  end

  def edit
    @post = Post.find_by(params[:id])
    p @post.author_id
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to  author_dashboard_path and return
    end
  end

  # def destroy
  #   @post = Post.find(params[:id])
  #   @post.destroy
  # end

  private
    def post_params
      params.require(:post).permit(:name, :content, :blog_id, :author_id)
    end
end
