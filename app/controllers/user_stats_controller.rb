class UserStatsController < ApplicationController
  before_action :authenticate_user!
  def index
    @user_stats = UserStat.all.includes(:user)
    
  end
end