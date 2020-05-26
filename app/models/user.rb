class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :user_stat, dependent: :destroy
  after_create :create_user_stat
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true
  before_save { self.email = email.downcase}

  has_many :questions, dependent: :destroy
  has_many :attempted_questions, dependent: :destroy
  
  acts_as_voter
  def answered(question)
    self.attempted_questions.where(question: question).first
  end
end
