require "selenium-webdriver"
options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--no-sandbox')
options.add_argument('--headless')
options.add_argument('--disable-gpu')
options.add_argument("--set-chrome-log-file File.absolute_path('chrome_log.txt', File.absolute_path)")
driver = Selenium::WebDriver.for :chrome, options: options

@tester_primary = {
    'email' => 'tester@lmrtfy.com',
    'password' => 'tester'
}

@tester_latest = {
    'email' => '',
    'password' => 'tester'
}


# Local development
if Rails.env.test? || Rails.env.development?
  driver.navigate.to "http://localhost:3000/users/sign_in"
end

# Live production
if Rails.env.production?
  driver.navigate.to "http://lmrtfy.com/users/sign_in"
end


# Wait in case the WebDriver doesn't wait for the page to load
wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
wait.until { driver.find_element(:id, 'user_email') }

# Sign in as the primary tester account
# Fill out the form:
driver.find_element(:id, 'user_email').send_keys(@tester_primary['email'])
driver.find_element(:id, 'user_password').send_keys(@tester_primary['password'])
driver.find_element(:name, 'commit').click

# Grab the email of the last created account
wait.until { driver.find_element(:id, 'last_created_account') }
@tester_latest['email'] = driver.find_element(:id, 'last_created_account').text

# Logging for debugging
logfile = File.new('console.out', 'w')
logfile.sync = true
logfile << "tester_primary = #{@tester_primary} \n"
logfile << "tester_latest = #{@tester_latest} \n"

# Confirm the latest account email is a test account
tester_regexp = /\A(tester-\d+@lmrtfy.com)\z/i
now_formatted = DateTime.now.strftime('%T%z')
tester_latest_email = "@tester_latest['email']: #{@tester_latest['email']}"

if tester_regexp.match?(@tester_latest['email']) === true
  logfile << "#{now_formatted} - INFO 1: #{tester_latest_email} matches tester account syntax: #{tester_regexp} ... \n continuing \n"
elsif tester_regexp.match?(@tester_latest['email']) === false
  logfile << "#{now_formatted} - ERROR 1 - #{tester_latest_email} email does not match tester account syntax: #{tester_regexp} ... \n aborting \n"
  exit
end

# Sign-out
driver.find_element(:id, 'user-sign-out').click

# Click the Sign-in nav button
driver.find_element(:id, 'user-sign-in').click

# Sign in as the latest tester account
driver.find_element(:id, 'user_email').send_keys(@tester_latest['email'])
driver.find_element(:id, 'user_password').send_keys(@tester_latest['password'])
driver.find_element(:name, 'commit').click

# Log a successful run
logfile << "#{now_formatted} - INFO 2: #{tester_latest_email} successfully logged in ... \n exiting \n"
