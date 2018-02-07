# Description: 
#   Perform a curl command to 
#     check if a username is available.
#   
# Usage: 
#   > ruby username_check.rb(search_term, search_site)

require 'open3' 

search_term = ARGV[0]
search_site = ARGV[1]

sites = [
  'reddit',
  'github'
]

print_sites = -> supported_sites {
  supported_sites.each do |site|
    puts site
  end  
}

# Check for required args
if ARGV[0].nil? || ARGV[1].nil?
  puts ("Expected two arguments: search_term, search_site \n")
  puts "Supported search_site arguments: \n"
  print_sites.call(sites)
  exit
end

curl_command =
  case search_site
  when "reddit"
    "curl -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36' -X GET 'https://www.reddit.com/user/#{search_term}'  -so - | \
      ruby -rnokogiri -e \
       'puts Nokogiri::HTML(readlines.join).xpath(\"//title\").map { |e| e.content }'"  
  when "github"
    "curl -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36' -X GET 'https://github.com/#{search_term}' -so - | \
      ruby -rnokogiri -e \
       'puts Nokogiri::HTML(readlines.join).xpath(\"//body\").map { |e| e.content }'"
  else
    "Error: Please include a valid search_site parameter"
  end

stdout_str, error_str, status = Open3.capture3(curl_command)
if status.success?
  case stdout_str.chomp.downcase
  # Reddit.com cases 
  when "#{search_term} (u/#{search_term}) - reddit"
    p true
  when "overview for #{search_term}"
    p true
  when (/page not found/)
    p false
  # Github.com case
  when /#{search_term}/
    p true
  when "not found"
    p false
  else
    p "#{search_term} is probably not a valid username, is a reserved word, or is unavailable to register. Exiting script."
    exit
  end
else
  raise "Error: #{error_str} \n"
end