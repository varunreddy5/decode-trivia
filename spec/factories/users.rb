FactoryBot.define do
  factory :user do
    name { "John Doe" }
    email { "johndoe@loremipsum.com" }
    password { "johndoe007" }
    password_confirmation { "johndoe007" }
  end
end
