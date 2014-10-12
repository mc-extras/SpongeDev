class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @user = current_user
    @plugin = Plugin.find(params[:plugin_id])
    return redirect_to @plugin, :alert => "You must sign in to comment." if not @user 
    @plugin.comments << @comment
    @user.comments << @comment
    if @comment.save
      redirect_to @plugin, :notice => "Successfully commented on #{@plugin.name}."
    else
      redirect_to @plugin, :notice => "Unable to submit your comment. Please make sure to fill out all fields."
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:user_id, :plugin_id, :content)
  end
end
