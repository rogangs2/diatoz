class BlogsController < ApplicationController
  def index
    @blogs = policy_scope(Blog)
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = current_user.blogs.new(blog_params)
    authorize @blog
    if @blog.save
      redirect_to  author_dashboard_path and return
    else
      render :new
    end
  end

  def edit
    @blog = Blog.find_by(params[:id])
    authorize @blog
  end

  def update
    @blog = Blog.find(params[:id])
    authorize @blog
    if @blog.update(blog_params)
      redirect_to  author_dashboard_path and return
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    authorize @blog
  end

  private
    def blog_params
      params.require(:blog).permit(:name, :description)
    end
end
