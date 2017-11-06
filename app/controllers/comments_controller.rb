class CommentsController < ApplicationController
  
  def create
    @comment = Comment.new
    @comment.user = current_user
    @comment.post = Post.find(params[:post_id])
    @comment.content = params[:comment][:content]
    @comment.save
    
    redirect_to @comment.post
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    if current_user == @comment.user
      @comment.destroy
    end
    post = Post.find(params[:post_id])
    
    redirect_to post
  end
  
end
