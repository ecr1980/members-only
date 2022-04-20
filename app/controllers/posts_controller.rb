class PostsController < ApplicationController

  def index
    @posts = Post.all
    @post = Post.new
  end  
  
  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html {redirect_to root_path, notice: "Good job posting, friend." }
        format.json { render :show, statis: :created, location: @post }
      else
        format.html {render :new, status: :unprocessable_entity }
        format.json {render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
  
end

