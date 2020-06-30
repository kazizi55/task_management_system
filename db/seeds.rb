20.times do |n|
  Task.create!(
    name: "テスト未着手#{n + 1}",
    explanation: "テストテスト",
    status: "not_started",
    deadline: Time.current + (n + 1).days
  )

  Task.create!(
    name: "テスト着手中#{n + 1}",
    explanation: "テストテスト",
    status: "in_progress",
    deadline: Time.current + (n + 1).days
  )

  Task.create!(
    name: "テスト完了#{n + 1}",
    explanation: "テストテスト",
    status: "completed",
    deadline: Time.current + (n + 1).days
  )
end
