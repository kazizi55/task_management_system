FactoryBot.define do
  factory :task do
    sequence(:name) { |n| "テスト#{n}" }
    explanation { 'テストテスト' }
    status { "not_started" }
    sequence(:deadline) { |n| Time.current + n.days }
    sequence(:created_at) { |n| Time.current + (n - 1).days }

    trait :in_progress do
      status { "in_progress" }
    end

    trait :completed do
      status { "completed" }
    end
  end
end
