require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation test' do
    let(:user) { described_class.new(params) }
    let(:params) { { name: name, email: email, password: password } }
    let(:name) { 'テスト太郎' }
    let(:email) { 'aaa@aaa.com' }
    let(:password) { '123456' }

    subject { user.valid? }

    before(:all) do
      create(:user)
    end

    after(:all) do
      User.find(1).destroy
    end

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
          expect(user.errors[:name]).to include('を入力してください')
        end
      end

      context 'email is nil' do
        let(:email) { nil }

        it 'returns an error message' do
          expect(subject).to eq false
          expect(user.errors[:email]).to include('を入力してください')
        end
      end

      context 'email is invalid format' do
        let(:email) { 'aa@aaaa' }

        it 'returns an error message' do
          expect(subject).to eq false
          expect(user.errors[:email]).to include('は不正な値です')
        end
      end

      context 'email is not unique' do
        let(:email) { 'test@test.com' }

        it 'returns an error message' do
          expect(subject).to eq false
          expect(user.errors[:email]).to include('はすでに存在します')
        end
      end

      context 'password is nil' do
        let(:password) { nil }

        it 'returns an error message' do
          expect(subject).to eq false
          expect(user.errors[:password]).to include('を入力してください')
        end
      end

      context 'password is less than 6 characters' do
        let(:password) { '1234' }

        it 'returns an error message' do
          expect(subject).to eq false
          expect(user.errors[:password]).to include('は6文字以上で入力してください')
        end
      end
    end
  end
end
