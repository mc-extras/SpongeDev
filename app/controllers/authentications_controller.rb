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

  # POST authentication token and username to verify valid token.
  def post_server
    form = params[:verification]
    username = form[:verification]
    token = form[:token]
    return redirect_to mc_server_path, :alert => "Invalid token or username." if !token or !username
    # uuid = add ability to get UUID, minecraft_auth gem preferably
    db_token = RegistrationToken.where(:token => token).where(:uuid => uuid).first
    return redirect_to mc_server_path, :alert => "Valid token not found." if not db_token # Token is invalid, not found.
    # Account is valid.
    # Save UUID to the user's model, redirect to root.
  end

  # POST Minecraft credentials to here where they can be verified.
  def post_credentials
    form = params[:account]
    username = form[:mc_username] # Filtered from logs
    password = form[:mc_password] # Filtered from logs
    return redirect_to root_path, :alert => "You must login to link your Minecraft account." unless @user = current_user
    begin
      @account = MinecraftAuth.account(username, password)
    rescue MinecraftAuth::AccountError
      return redirect_to mc_credentials_path, :alert => "Invalid login credentials."
    end
    @user.mc_uuid = @account.profiles[0].id
    @user.save
    redirect_to root_path, :notice => "Successfully linked Minecraft account."
  end
end
