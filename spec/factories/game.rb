# frozen_string_literal: true

FactoryGirl.define do
  factory :game do
    date { Chronic.parse('now') }
    time { Chronic.parse('now') }
    opponent { Faker::Team.state }

    trait :home do
      location :home
    end

    trait :away do
      location :away
    end

    trait :tbd do
      time nil
    end
  end
end
