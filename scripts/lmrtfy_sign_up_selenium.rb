require "selenium-webdriver"
options = Selenium::WebDriver::Chrome::Options.new
options.add_argument('--no-sandbox')
options.add_argument('--headless')
options.add_argument('--disable-gpu')
driver = Selenium::WebDriver.for :chrome, options: options

@tester = {
    'email' => 'tester-' + rand(1000000).to_s + '@lmrtfy.com',
    'password' => 'tester'
}

# Local development
if Rails.env.test? || Rails.env.development?
  driver.navigate.to "http://localhost:3000/users/sign_up"
end

# Live production
if Rails.env.production?
  driver.navigate.to "http://lmrtfy.com/users/sign_up"
end

# WebDriver may not wait for the page to load
wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
wait.until { driver.find_element(:id, 'user_email') }

# Email
driver.find_element(:id, 'user_email').send_keys(@tester['email'])

# Password
driver.find_element(:id, 'user_password').send_keys(@tester['password'])
driver.find_element(:id, 'user_password_confirmation').send_keys(@tester['password'])

# Submit form
driver.find_element(:name, 'commit').click
