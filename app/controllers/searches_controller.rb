class SearchesController < ApplicationController
  before_action :require_login
  before_action :set_search, only: [:show, :edit, :update, :destroy]

  def create
    @search = Search.new(search_params)
    @search.user_id = current_user.id
    if @search.save
      
      begin
        @results = Search.new.is_term_taken?(search_params[:term])

        if @results === true
          gflash :warning => "#{search_params[:term]} is unavailable"
        elsif @results === false
          gflash :success => "#{search_params[:term]} is available"
        end 

      rescue OpenURI::HTTPError
        gflash :success => "#{search_params[:term]} is available"
      end

    end

    respond_to do |f|
      f.html
      f.js
    end

    redirect_to :new_search
      
  end

  def destroy
    @search.delete
    redirect_to @search, notice: "Your search was deleted successful"
  end

  def edit
  end

  def index

  end

  def new
    @search = Search.new
  end

  def show
  end

  def update
    if @search.update(search_params)
      redirect_to @search, notice: "Your search was updated successfully"
    else
      render :edit
    end
  end

  private

  def search_params
    params.require(:search).permit(:term, :user)
  end

  def set_search
    @search = Search.find(params[:id])
  end

  def require_login
    unless current_user
      redirect_to root_url
    end
  end

end
