FactoryBot.define do
  factory :label do
    sequence(:id) { |n| n }
    sequence(:name) { |n| "ラベル#{n}" }
  end
end
