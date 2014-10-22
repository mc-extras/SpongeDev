class AuthenticationsController < ApplicationController
  # Verify with Minecraft credentials
  def credentials
    render 'verify', :locals => { :type => "credentials" }
  end

  # Verify with authentication server
  def server
    render 'verify', :locals => { :type => "server" }
  end

  # Managing action for all verification methods
  def verify
  end

  # Post Minecraft credentials to here where they can be verified.
  def post_mc
    form = params[:account]
    username = form[:mc_username] # Filtered from logs
    password = form[:mc_password] # Filtered from logs
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
end
