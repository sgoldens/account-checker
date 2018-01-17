require "selenium-webdriver"
driver = Selenium::WebDriver.for :chrome

@tester = {
    'email' => 'tester-' + rand(1000000).to_s + '@lmrtfy.com',
    'password' => 'tester'
}

driver.navigate.to "http://lmrtfy.com/users/sign_up"

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