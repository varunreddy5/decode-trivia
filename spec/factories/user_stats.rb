FactoryBot.define do
  factory :user_stat do
    right_streak { 1 }
    wrong_streak { 1 }
    max_right_streak { 1 }
    max_wrong_streak { 1 }
  end
end
