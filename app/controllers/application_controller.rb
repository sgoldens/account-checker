class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def index
  end

  def self.local_prefixes
    ['shared', controller_path]
  end
  private_class_method :local_prefixes
end