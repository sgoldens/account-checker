class SearchesController < ApplicationController
  before_action :require_login

  def index
    @search = Search.new
  end

  def show
  end

  def create
    @search = Search.new({term: search_params, user: current_user})
    @result = Search.new.is_term_available(search_params)
    respond_to do |f|
      if @search.save
        f.html
        f.js 
      else
        f.html { render 'index' }
      end
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
