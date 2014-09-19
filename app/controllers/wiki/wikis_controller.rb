class Wiki::WikisController < ApplicationController
  def show
    @wiki = Wiki::Wiki.find(params[:id])
  end
end
