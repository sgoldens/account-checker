class SearchesController < ApplicationController
  before_action :require_login
  before_action :set_search, only: [:show, :edit, :update, :destroy]

  def index

  end

  def create
    @search = Search.new(search_params)
    @search.user_id = current_user.id
    @sites = ['reddit', 'github']

    if !search_params[:term].match /\A(^[\Aa-zA-Z0-9_]{3,20})\z/i
      gflash :error => "Username #{search_params[:term]} is invalid"
    end

    if search_params[:term].match /\A(^[\Aa-zA-Z0-9_]{3,20})\z/i
      if @search.save
        @sites.each do |site|

          begin

            @result = Search.new.is_term_taken?(site, search_params[:term])

            case site
            when 'reddit'
              site = 'Reddit.com'
            when 'github'
              site = 'GitHub.com'
            end

            if @result === true
              gflash :warning => "Username #{search_params[:term]} is not available on #{site}"
            elsif @result === false
              gflash :success => "Username #{search_params[:term]} is available on #{site}"
            end 

          rescue OpenURI::HTTPError
            gflash :success => "Username #{search_params[:term]} is available on #{site}"
          end

        end
      end
    end

    respond_to do |f|
      f.html
      f.js
    end

    redirect_to :new_search
    
  end

  def new
    @search = Search.new
  end

  def destroy
    @search.delete
    redirect_to @search, notice: "Your search was deleted successful"
  end

  def edit
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
    params.require(:search).permit(:site, :term, :user)
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
