require 'rails_helper'

RSpec.describe Label, type: :model do
  describe 'validation test' do
    let(:label) { described_class.new(params) }
    let(:params) { { name: name } }
    let(:name) { 'テスト' }

    subject { label.valid? }

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
          expect(label.errors[:name]).to include('を入力してください')
        end
      end
    end
  end
end
