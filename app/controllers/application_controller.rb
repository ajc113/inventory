class ApplicationController < ActionController::Base
  include NavBar
  include Authenticate
  include Authorization
  include Pagy::Backend
  include ExceptionHandler

  before_action :set_stores
  before_action :set_inventories
end
