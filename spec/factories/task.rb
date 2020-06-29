FactoryBot.define do
  factory :task_A, class: Task  do
    sequence(:name) { |n| "テストA-#{n}" }
    explanation { 'テストテスト' }
    status { 0 }
    sequence(:deadline) { |n| Time.current + n.days }
    sequence(:created_at) { |n| Time.current + (n - 1).days }
  end

  factory :task_B, class: Task  do
    sequence(:name) { |n| "テストB-#{n}" }
    explanation { 'テストテスト' }
    status { 1 }
    sequence(:deadline) { |n| Time.current + n.days }
    sequence(:created_at) { |n| Time.current + (n - 1).days }
  end

  factory :task_C, class: Task  do
    sequence(:name) { |n| "テストC-#{n}" }
    explanation { 'テストテスト' }
    status { 2 }
    sequence(:deadline) { |n| Time.current + n.days }
    sequence(:created_at) { |n| Time.current + (n - 1).days }
  end
end
