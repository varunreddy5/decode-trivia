class AttemptedQuestionsController < ApplicationController
  def index
    @attempted_questions = current_user.attempted_questions
  end
end