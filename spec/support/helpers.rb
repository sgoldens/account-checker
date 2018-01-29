module Helpers
  def sign_in(resource)
    visit new_user_session_path

    fill_in 'Email', with: resource.email
    fill_in 'Password', with: resource.password
    click_button 'Log in'
  end
end

RSpec.configure do |config|
  config.include Helpers, type: :feature
end
