class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include SessionsHelper #to include the build-in model
end
