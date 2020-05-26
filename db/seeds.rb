# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user = User.create(name: "test", email: "test@example.com", password: "varun2@7", password_confirmation: "varun2@7")

20.times do |i|
  question = Question.create(title: "Test Question #{i}", user: user)
  question.tag_ids = [Tag.last.id]
  puts question.title
  (1..4).each do |n|
    Option.create(question: question, name: "Test Option", correct: (n == 2))
  end
  question.save
end