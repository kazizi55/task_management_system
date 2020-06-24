require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'タスク名が空の場合' do
    task = Task.new(name: nil, explanation: 'テストテスト')
    task.valid?
    
    it 'エラーメッセージを返す' do
      expect(task.errors[:name]).to include('を入力してください')
    end
  end
end
