class UsersController < ApplicationController

  before_filter :set_user, only: [:show]
  before_filter :require_admin, only: [:index] # Require admin to view user list

  def index
    @users = User.all

    respond_to do |format|
      format.html
      format.json { render json: @users }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def about

  end

  def avatar
  end

  def notifications

  end

  private

  def set_user
    unless @user = User.find_by_username(params[:id])
      raise ActiveRecord::RecordNotFound # 404 Not Found
    end
  end
end
