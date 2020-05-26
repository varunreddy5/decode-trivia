class Question < ApplicationRecord
  belongs_to :user
  has_many :question_tags
  has_many :tags, through: :question_tags, dependent: :destroy
  has_many :options, inverse_of: :question, dependent: :destroy
  accepts_nested_attributes_for :options, reject_if: :all_blank, allow_destroy: true
  has_many :attempted_questions, dependent: :destroy
  acts_as_votable
end
