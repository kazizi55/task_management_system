require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation test' do
    let(:task) { described_class.new(params) }
    let(:params) { { name: name, explanation: explanation, status: status, priority: priority, deadline: deadline } }
    let(:name) { 'テスト' }
    let(:explanation) { 'テストテスト' }
    let(:status) { 'not_started' }
    let(:priority) { 'low' }
    let(:deadline) { Time.current.tomorrow }

    subject { task.valid? }

    context 'when success' do
      it 'validates successfully' do
        expect(subject).to eq true
      end
    end

    context 'when fail' do
      context 'name is nil' do
        let(:name) { nil }

        it 'returns an error message' do
          expect(subject).to eq false
          expect(task.errors[:name]).to include('を入力してください')
        end
      end

      context 'priority is nil' do
        let(:priority) { nil }

        it 'returns an error message' do
          expect(subject).to eq false
          expect(task.errors[:priority]).to include('を入力してください')
        end
      end

      context 'deadline is nil' do
        let(:deadline) { nil }

        it 'returns an error message' do
          expect(subject).to eq false
          expect(task.errors[:deadline]).to include('を入力してください')
        end
      end

      context 'deadline is past' do
        let(:deadline) { Time.current.yesterday }

        it 'returns an error message' do
          expect(subject).to eq false
          expect(task.errors[:deadline]).to include('は過去の日時は選択できません')
        end
      end
    end
  end
end
