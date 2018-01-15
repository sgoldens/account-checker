require 'open-uri'

class Search < ApplicationRecord
  belongs_to :user

  validates :term, length: { within: 3..20 } 

  def is_term_available(input)
    if input.empty?
      "Please enter a search term"
    end
    begin
      html = open("https://reddit.com/user/#{input}",
                  "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36").read
      if html
        # BUG: Title tags are case sensitive, so the search term and the title tag should to be transformed to the
        # same case before checking
        if html.include?("<title>#{input} (u/#{input}) - Reddit</title>") || html.include?("<title>overview for ")
          "User name already exists on Reddit"
        elsif html.include?("<title>reddit.com: page not found</title>")
          "User name is probably available (but is returning a 404 error)"
        else
          "#{input} might not be a valid user name for Reddit.com"
        end
      else
        "Sorry, that search term doesn't seem to be working"
      end
    rescue OpenURI::HTTPError => ex
      "User name is probably available (404 error)"
    end 
  end

end
