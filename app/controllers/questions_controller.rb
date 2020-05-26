class QuestionsController < ApplicationController
  before_action :authenticate_user!
  def new
    @question = Question.new
    4.times do 
      @question.options.new
    end
  end

  def index
    if params[:tag] == "all-tags"
      questions = Question.all
    else
      tag = Tag.find(params[:tag])
      questions = tag.questions
    end
    attempted_questions = current_user.attempted_questions.map(&:question_id)
    @question = questions.where.not(id: attempted_questions).limit(1).first
    # .sort_by{|q|-(q.get_upvotes.size-q.get_downvotes.size)*rand()}
  end
  
  def get_questions
    tag = Tag.find(params[:tag])
    questions = tag.questions
    attempted_questions = current_user.attempted_questions.map(&:question_id)
    @questions = questions.where.not(id: attempted_questions).limit(10)
    render json: @questions.map(&:id)
  end

  def show 
    @question = Question.find(params[:id])
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.update_attributes(question_params)
    redirect_to @question
  end
  def create
    @question = Question.new(question_params)
    @question.user = current_user
    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def check_answer
    @question = Question.find(params[:id])
    @submitted_answer_id = params[:answer].to_i
    @correct_answer_id = @question.options.where(correct: true).first.id
    user_stat = current_user.user_stat
    if @submitted_answer_id == @correct_answer_id
      current_user.score += 4
      @correct_answer = true
      user_stat.right_streak += 1
      user_stat.max_right_streak = user_stat.right_streak > user_stat.max_right_streak ? user_stat.right_streak : user_stat.max_right_streak
      user_stat.wrong_streak = 0 if user_stat.wrong_streak > 0
      
    else
      current_user.score -= 1
      @correct_answer = false
      user_stat.wrong_streak += 1
      user_stat.max_wrong_streak = user_stat.wrong_streak > user_stat.max_wrong_streak ? user_stat.wrong_streak : user_stat.max_wrong_streak
      user_stat.right_streak = 0 if user_stat.right_streak > 0
    end
    current_user.save
    user_stat.save
    current_user.attempted_questions.create(question: @question, user_answer: @submitted_answer_id)

    # category_score
    @question.tags.each do |tag|
      if current_user.tag_scores.where(tag: tag).blank?
        tag_score=current_user.tag_scores.create(tag: tag)
      else
        tag_score = current_user.tag_scores.where(tag: tag).first
      end
      if @correct_answer
        tag_score.score += 4
      else
        tag_score.score -= 1
      end
      tag_score.save
    end
    respond_to do |format|
      format.js { render layout: false}
    end
  end

  def upvote
    @question = Question.find(params[:id])
    @question.upvote_from current_user
    respond_to do |format|
      format.js{ render layout: false}
    end
  end

  def downvote
    @question = Question.find(params[:id])
    @question.downvote_from current_user
    respond_to do |format|
      format.js{ render layout: false}
    end
  end
  private
  def question_params
    params.require(:question).permit(:title, tag_ids: [], options_attributes: [:id, :name, :correct, :_destroy])
  end
end