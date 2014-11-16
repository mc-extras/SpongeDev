class AuthenticationsController < ApplicationController
  before_filter :authenticate_user!, only: [:credentials, :server, :verify]
  before_filter :authenticate_auth_server!, only: :set_token
  skip_before_filter :verify_authenticity_token, only: :set_token

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

  # used by authentication server to set uuid/token
  def set_token
    rt = RegistrationToken.find_by(uuid: params[:uuid]) || RegistrationToken.new(uuid: params[:uuid])
    rt.token = params[:token]
    render json: {success: rt.save, errors: rt.errors}
  end

  # POST authentication token and username to verify valid token.
  def post_server
    unless user = current_user
      return redirect_to root_path, alert: "You must login to authenticate with our server."
    else
      form = params[:verification]
      username = form[:username]
      token = form[:token]
      unless token and username
        return redirect_to mc_server_path, alert: "Invalid token or username."
      else
        uuid = MinecraftAuth.username_to_uuid(username) # Convert UUID to username from Mojang servers.
        puts "TOKEN", token, "UUID", uuid
        db_token = RegistrationToken.find_by(uuid: uuid, token: token)
        unless db_token # Token is invalid, not found.
          return redirect_to mc_server_path, alert: "Valid token not found."
        else
          user.mc_uuid = uuid
          user.mc_username = username
          user.avatar_serve = "Crafatar"
          user.save
          redirect_to root_path, notice: "Successfully linked Minecraft account."
        end
      end
    end
  end

  # POST Minecraft credentials to here where they can be verified.
  def post_credentials
    form = params[:account]
    username = form[:mc_username] # Filtered from logs
    password = form[:mc_password] # Filtered from logs
    unless @user = current_user
      return redirect_to root_path, :alert => "You must login to link your Minecraft account."
    else
      begin
        @account = MinecraftAuth.account(username, password)
      rescue MinecraftAuth::AccountError
        return redirect_to mc_credentials_path, :alert => "Invalid login credentials."
      end
      @user.mc_uuid = @account.profiles[0].id
      @user.mc_username = username
      @user.avatar_serve = "Crafatar"
      @user.save
      redirect_to root_path, :notice => "Successfully linked Minecraft account."
    end
  end

  private

  def authenticate_auth_server!
    unless ENV["AUTH_SERVER_KEY"] and ENV["AUTH_SERVER_KEY"] == request.headers["X-Auth-Server-Key"]
      puts "Unauthorized access: #{ENV["AUTH_SERVER_KEY"]} - #{request.headers["X-AUTH-SERVER-KEY"]}"
      render text: "unauthorized", status: 403
    end
  end
end
