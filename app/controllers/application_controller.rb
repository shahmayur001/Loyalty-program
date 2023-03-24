# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  # turns on request forgery protection and checks for the CSRF token in non-GET and non-HEAD requests.
  protect_from_forgery
end
