require 'open-uri'

class Search < ApplicationRecord
  belongs_to :user

  validates_format_of :term, with: /\A(^[\Aa-zA-Z0-9_-]{3,20})\z/i, on: :create
  validates :user_id, presence: true

  attr_accessor :html, :term

  def is_term_taken?(input)
    @html = open("https://reddit.com/user/#{input}",
                "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36").read
    # BUG: Title tags are case sensitive, so the search term and the title tag should to be transformed to the
    # same case before checking
    if @html.include?("<title>#{input} (u/#{input}) - Reddit</title>") || @html.include?("<title>overview for ")
      true
    else
      false
    end
  end

end