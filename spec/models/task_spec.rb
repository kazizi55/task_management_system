require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'タスク名が空の場合は無効' do
    task = Task.new(name: nil, explanation: 'テストテスト')
    task.valid?
    expect(task.errors[:name]).to include('を入力してください')
  end
end
