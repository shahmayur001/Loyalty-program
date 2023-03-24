# frozen_string_literal: true

class UsersRewardsController < ApplicationController
  # GET /rewards
  def index
    @rewards = current_user.rewards
  end
end
