FactoryBot.define do
  factory :label_task do
    label_id { 1 }
    sequence(:task_id) { |n| n }
  end
end
