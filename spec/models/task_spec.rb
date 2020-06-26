require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation test' do
    let(:task) { described_class.new(params) }
    subject { task.valid? }

    context 'when success' do
      let(:params) { { name: 'テスト', explanation: 'テストテスト', deadline: Time.current.tomorrow } }

      it 'validates successfully' do
        is_expected.to eq true
      end
    end

    context 'when fail' do
      context 'name is nil' do
        let(:params) { { name: nil, explanation: 'テストテスト' } }

        it 'returns an error message' do
          is_expected.to eq false
          expect(task.errors[:name]).to include('を入力してください')
        end
      end

      context 'deadline is nil' do
        let(:params) { { name: 'テスト', explanation: 'テストテスト', deadline: nil } }

        it 'returns an error message' do
          is_expected.to eq false
          expect(task.errors[:deadline]).to include('を入力してください')
        end
      end

      context 'deadline is past' do
        let(:params) { { name: 'テスト', explanation: 'テストテスト', deadline: Time.current.yesterday } }

        it 'returns an error message' do
          is_expected.to eq false
          expect(task.errors[:deadline]).to include('は過去の日時は選択できません')
        end
      end
    end
  end
end
