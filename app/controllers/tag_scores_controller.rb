class TagScoresController < ApplicationController
  before_action :authenticate_user!
  def index
    @tag_scores = TagScore.where(user: current_user).order(score: :desc)
  end
end