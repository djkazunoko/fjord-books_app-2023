# frozen_string_literal: true

FactoryBot.define do
  factory :report do
    title { 'report' }
    content { 'A test report.' }
    association :user
  end
end
