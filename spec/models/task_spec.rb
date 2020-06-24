require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) { described_class.new(params) }
  subject { task.valid? }

  describe '正常系' do
    context '問題ない場合' do
      let(:params) { { name: 'テスト', explanation: 'テストテスト' } }

      it 'バリデーションを通過' do
        is_expected.to eq true
      end
    end
  end

  describe '異常系' do
    context 'カラム名が空の場合' do
      let(:params) { { name: nil, explanation: 'テストテスト' } }

      it 'エラーメッセージを返す' do
        is_expected.to eq false
        expect(task.errors[:name]).to include('を入力してください')
      end
    end
  end
end
