require 'open3' 

# Author: Sasha Goldenson
# License: Free to use
#
# Description: 
#   Perform a curl command to Reddit
#   and check if a username is already taken or not.
#   
# Usage: 
#   > ruby reddit_username_check.rb "#{search_term}"
# 
# If the Reddit user already exists, 
#   the curl returns the <title> HTML tag: 
#     => "#{search_term} (u/#{search_term}) - Reddit"
#     and the script exits with status TRUE
#
# Else, the Reddit user doesn't exist,
#   and the curl returns 
#     => reddit.com: page not found
#     and the script exits with status FALSE

search_term = ARGV[0]

curl_command = "curl -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36' -X GET 'https://www.reddit.com/user/#{search_term}'  -so - | \
    ruby -rnokogiri -e \
     'puts Nokogiri::HTML(readlines.join).xpath(\"//title\").map { |e| e.content }'"

stdout_str, error_str, status = Open3.capture3(curl_command)
if status.success?
  case stdout_str.chomp
  when "#{search_term} (u/#{search_term}) - Reddit"
    p true
    exit true
  when "overview for #{search_term}"
    p true
    exit true
  when "reddit.com: page not found"
    p false
    exit false
  else
    p "#{search_term} is probably not a valid username, a reserved word, or unavailable to register. Exiting script w/o true or false."
    exit
  end
else
  raise "Error: #{error_str} \n"
end