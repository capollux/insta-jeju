class PostsController < ApplicationController
    
  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
  end
  
  def create
    post = Post.new
    post.image = params[:post][:image]
    post.content = params[:post][:content]
    post.save
    
    redirect_to post
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    post = Post.find(params[:id])
    post.image = params[:post][:image]
    post.content = params[:post][:content]
    post.save
    
    redirect_to post
  end
  
  def destroy
    post = Post.find(params[:id])
    post.destroy
    
    redirect_to "/posts"
  end
    
end
