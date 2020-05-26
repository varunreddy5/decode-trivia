class UserStatsController < ApplicationController
  def index
    @user_stats = UserStat.all.includes(:user)
    
  end
end