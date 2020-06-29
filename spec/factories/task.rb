FactoryBot.define do
  factory :task  do
    sequence(:name) { |n| "テスト#{n}" }
    explanation { 'テストテスト' }
    sequence(:deadline) { |n| Time.current + n.days }
    sequence(:created_at) { |n| Time.current + (n - 1).days }
  end
end
