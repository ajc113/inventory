class ApplicationController < ActionController::Base
  include Authenticate
  include Authorization
  include ExceptionHandler
end
