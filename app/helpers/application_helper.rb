module ApplicationHelper
  include Pagy::Frontend

  def best_category(user)
    TagScore.where(user: user).order(score: :desc).first.tag.name
  end
end
