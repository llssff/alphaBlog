class DefaultsController < ApplicationController
  def about

  end


  def main
    redirect_to articles_path if logged_in?
  end
end
