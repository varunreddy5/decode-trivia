FactoryBot.define do
  factory :attempted_question do
    user { nil }
    question { nil }
    user_answer { 1 }
  end
end
