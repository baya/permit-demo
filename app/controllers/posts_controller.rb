class PostsController < ApplicationController

  # before_filter :fence_create_post, only: [:new, :create]

  def index
    @posts = Post.order('created_at desc').includes(:user)
  end

  def new
    fence :create_post do
      @post = Post.new
      render :new
    end
  end

  def create
    fence :create_post do
      @post = current_user.posts.create(post_params)
      if @post.valid?
        redirect_to action: 'index'
      else
        render :new
      end
    end  
  end

  def edit
    @post = Post.find(params[:id])
    fence(:edit_post, @post) do
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  # def fence_create_post
  #   fence :create_post
  # end
  
end
