class PostsController < ApplicationController
    
  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new
    @post.image = params[:post][:image]
    @post.content = params[:post][:content]
    @post.user = current_user
    if @post.save
      redirect_to @post
    else
      render :new
    end
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def edit
    @post = Post.find(params[:id])
    unless current_user == @post.user
      redirect_to root_path
    end
  end
  
  def update
    post = Post.find(params[:id])
    
    unless current_user == post.user
      redirect_to root_path
    else
      post.image = params[:post][:image]
      post.content = params[:post][:content]
      post.save
      
      redirect_to post
    end
  end
  
  def destroy
    post = Post.find(params[:id])
    
    unless current_user == post.user
      redirect_to root_path
    else
      post.destroy
      
      redirect_to "/posts"
    end
    
  end
  
  def mypage
    @posts = current_user.posts
  end
    
end
