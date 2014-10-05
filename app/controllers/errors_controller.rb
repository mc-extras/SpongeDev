class ErrorsController < ApplicationController
  def page_not_found
    redirect_to root_path, :alert => '404 page not found! If you believe this is an error, please contact support.', status: 404
  end

  def server_error
    redirect_to root_path, :alert => '500 something went wrong! If you believe this is an error, please contact support.', status: 404
  end
end
