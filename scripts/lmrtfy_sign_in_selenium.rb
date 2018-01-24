require "selenium-webdriver"
options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--no-sandbox')
# options.add_argument('--headless')
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

# Logging for debug
logfile = File.new('console.out', 'w')
logfile.sync = true

if @tester_latest['email'] != /\A(^tester)\z/i
  logfile << "#{DateTime.now.strftime('%T%z')} - ERROR - @tester_latest['email']: #{@tester_latest['email']} email does not match tester account syntax, aborting."
  exit
elsif @tester_latest['email'] === /\A(^[tester-]\d{1,}@lmrtfy.com)\z/i
  logfile << "Info: @tester_latest['email']: #{@tester_latest['email']} matches tester account syntax, continuing."
else
  logfile << "Error: Unknown regexp matching error for @tester_latest['email'], aborting"
  exit
end

# Logging for debug
logfile << "tester_primary = #{@tester_primary} \n"
logfile << "tester_latest = #{@tester_latest} \n"

# Confirm the latest account email is a test account
Selenium::WebDriver::Wait(:timeout => 5)
# Sign-out

# Click the Sign-in nav button


# Email

# Password

# # Submit form
