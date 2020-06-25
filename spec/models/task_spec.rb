require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation test' do
    let(:task) { described_class.new(params) }
    subject { task.valid? }

    context 'when success' do
      let(:params) { { name: 'テスト', explanation: 'テストテスト' } }

      it 'validates successfully' do
        is_expected.to eq true
      end
    end

    context 'when fail' do
      context 'name column is nil' do
        let(:params) { { name: nil, explanation: 'テストテスト' } }

        it 'returns an error message' do
          is_expected.to eq false
          expect(task.errors[:name]).to include('を入力してください')
        end
      end
    end
  end
end
