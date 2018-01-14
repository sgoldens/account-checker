class SearchesController < ApplicationController
  before_action :require_login

  def index
    @search = Search.new
  end

  def show
  end

  def create
    @result = Search.new.is_term_available(search_params)    
    respond_to do |f|
      f.html
      f.js 
    end
  end

  private

  def search_params
    params[:search][:term]
  end

  def require_login
    unless current_user
      redirect_to root_url
    end
  end

end
