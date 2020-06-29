require 'rails_helper'

RSpec.describe Task, type: :model do
  describe 'validation test' do
    let(:task) { described_class.new(params) }
    subject { task.valid? }

    context 'when success' do
      let(:params) { { name: 'テスト', explanation: 'テストテスト', status: 0, deadline: Time.current.tomorrow } }

      it 'validates successfully' do
        expect(subject).to eq true
      end
    end

    context 'when fail' do
      context 'name is nil' do
        let(:params) { { name: nil, explanation: 'テストテスト', status: 0, deadline: Time.current.tomorrow } }

        it 'returns an error message' do
          expect(subject).to eq false
          expect(task.errors[:name]).to include('を入力してください')
        end
      end

      context 'deadline is nil' do
        let(:params) { { name: 'テスト', explanation: 'テストテスト', status: 0, deadline: nil } }

        it 'returns an error message' do
          expect(subject).to eq false
          expect(task.errors[:deadline]).to include('を入力してください')
        end
      end

      context 'deadline is past' do
        let(:params) { { name: 'テスト', explanation: 'テストテスト', status: 0, deadline: Time.current.yesterday } }

        it 'returns an error message' do
          expect(subject).to eq false
          expect(task.errors[:deadline]).to include('は過去の日時は選択できません')
        end
      end
    end
  end

  describe 'search test' do
    before(:each) do
      create_list(:task_A, 3)
      create_list(:task_B, 3)
      create_list(:task_C, 3)
    end

    let(:task) { described_class.ransack(query) }
    subject { task.result }

    context 'search by name' do
      let(:query) { { "name_cont" => "テストA" } }

      it 'returns correct result' do
        expect(subject.length).to eq 3
        expect(subject[0].name).to eq "テストA-1"
      end
    end

    context 'search by status' do
      let(:query) { { "status_eq" => "1" } }

      it 'returns correct result' do
        expect(subject.length).to eq 3
        expect(subject[0].status).to eq "in_progress"
      end
    end

    context 'search by name and status' do
      let(:query) { { "name_cont" => "テストC", "status_eq" => "2" } }

      it 'returns correct result' do
        expect(subject.length).to eq 3
        expect(subject[0].name).to eq "テストC-7"
        expect(subject[0].status).to eq "completed"
      end
    end
  end
end
