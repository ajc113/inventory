class ApplicationController < ActionController::Base
  include Authenticate
  include Authorization
end
