FactoryBot.define do
  factory :user do
    id { 1 }
    name { "テスト太郎" }
    email { "test@test.com" }
    password { "123456".crypt(Rails.application.credentials.salt[:salt_key]) }
  end
end
