# spec/factories/tasks.rb
FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    due_date { Faker::Date.forward(days: 14) } # Example: due in 2 weeks
    status { Task.statuses.keys.sample } # Randomly assign a status
    user
  end
end
