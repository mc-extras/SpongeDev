class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  include ApplicationHelper

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  def contact
    form = params[:contact]
    username = form[:username]
    email = form[:email]
    question = form[:question]
    return redirect_to root_path, notice: 'Please make sure to fill all fields.' if username == nil or email == nil or question == nil
    UserMailer.contact(email, username, question).deliver
    return redirect_to root_path, notice: 'Successfully submitted an inquiry.'
  end

  def post_mc
    form = params[:account]
    username = form[:mc_username]
    password = form[:mc_password]
    return redirect_to root_path, :notice => "You must login to link your Minecraft account." unless @user = current_user
    begin
      @account = MinecraftAuth.account(username, password)
    rescue MinecraftAuth::AccountError
      return redirect_to root_path, :notice => "Invalid login credentials."
    end
    @user.mc_uuid = @account.profiles[0].id
    @user.mc_username = @account.profiles[0].name
    @user.save
    redirect_to root_path, :notice => "Successfully linked Minecraft account."
  end

  def link_mc
  end
end
