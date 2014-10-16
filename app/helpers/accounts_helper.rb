module AccountsHelper
  def is_valid_account(username, password)
    require 'minecraft_auth'
    MinecraftAuth.account(username, password)
  end
end
