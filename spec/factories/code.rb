# frozen_string_literal: true

FactoryBot.define do
  factory :code, class: Code do
    answer { Faker::Lorem.paragraph }
    language_id { Faker::Number.digit }
    problem_id { Faker::Number.number(digits: 4) }
    token { Faker::Internet.uuid }
  end
end
