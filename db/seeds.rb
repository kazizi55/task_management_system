20.times do |n|
  Task.create!(
    name: "テスト未着手#{n + 1}",
    explanation: "テストテスト",
    status: 0,
    deadline: Time.current + (n + 1).days
  )

  Task.create!(
    name: "テスト着手中#{n + 1}",
    explanation: "テストテスト",
    status: 1,
    deadline: Time.current + (n + 1).days
  )

  Task.create!(
    name: "テスト完了#{n + 1}",
    explanation: "テストテスト",
    status: 2,
    deadline: Time.current + (n + 1).days
  )
end
