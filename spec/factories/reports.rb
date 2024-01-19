# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    sequence(:title) { |n| "report#{n}" }
    sequence(:content) { |n| "A test report#{n}." }
    association :user
  end
end
