3.times do |n|
  User.create!(
    id: n + 1,
    name: "テスト太郎#{n + 1}",
    email: "test#{n + 1}@test.com",
    password: "123456".crypt(Rails.application.credentials.salt[:salt_key])
  )
end

5.times do |m|
  3.times do |n|
    Task.create!(
      name: "テスト未着手#{m + 1}",
      explanation: "テストテスト",
      status: "not_started",
      deadline: Time.current + (m + 1).days,
      user_id: n + 1
    )

    Task.create!(
      name: "テスト着手中#{m + 1}",
      explanation: "テストテスト",
      status: "in_progress",
      deadline: Time.current + (m + 1).days,
      user_id: n + 1
    )

    Task.create!(
      name: "テスト完了#{m + 1}",
      explanation: "テストテスト",
      status: "completed",
      deadline: Time.current + (m + 1).days,
      user_id: n + 1
    )
  end
end
