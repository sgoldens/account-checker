class TasksController < ApplicationController

  # GET /
  # GET /tasks
  def index
    @tester = User.last
  end

  def new_test_account
    result = %x(bin/rails runner scripts/lmrtfy_sign_up_selenium.rb)
    redirect_to home_path
  end

  def sign_in_as_new_test_account
    result = %x(bin/rails runner scripts/lmrtfy_sign_in_selenium.rb)
    redirect_to home_path
  end

  def remove_latest_test_account
    result = %x(bin/rails runner scripts/lmrtfy_remove_latest_user_selenium.rb)
    redirect_to home_path
  end

end
