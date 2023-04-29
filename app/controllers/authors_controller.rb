class AuthorsController < ApplicationController
  skip_before_action :logged_in?

  def new
    @person = Author.new
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      log_in @author
      redirect_to  author_dashboard_path and return
    else
      flash[:notice] = "unable to create author"
      render :new
    end
  end

  def index
    @authors = Author.all
  end

  def show
    @author = Author.includes(:posts, :blogs, :comments).find(params[:id])
  end

  private
    def author_params
      params.require(:author).permit(:name, :email, :password)
    end
end
