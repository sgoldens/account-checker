class HomeController < ApplicationController
  protect_from_forgery with: :exception

  # GET /
  # GET /home
  def index
    @tester = User.last
  end

end
