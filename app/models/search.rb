require 'open-uri'

class Search < ApplicationRecord
  belongs_to :user

  validates_presence_of :term

  attr_accessor :html, :site, :term

  def is_term_taken?(site, term)
    # check per site for username validation rules
    case site
    when 'reddit'
      site_url = "https://www.reddit.com/user/"
      return true if !term.match /\A(^[\Aa-zA-Z0-9_-]{3,20})\z/i
    when 'github'
      site_url = "https://github.com/"
      return true if !term.match /\A(^[\Aa-zA-Z0-9_]{3,20})\z/i
    else
      exit
    end

    @html = open("#{site_url}#{term}",
                "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36").read
    if @html.include?("there doesn't seem to be anything here") || @html.include?("Not Found")
      false
    elsif @html.include?("<title>#{term} (u/#{term}) - Reddit</title>") || @html.include?("<title>overview for ") || @html.include?(term)
      true
    end
  end

end