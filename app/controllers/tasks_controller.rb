class TasksController < ApplicationController

  def new_test_account
    result = %x(bin/rails runner scripts/lmrtfy_sign_up_selenium.rb)
    redirect_to home_path
  end

end
