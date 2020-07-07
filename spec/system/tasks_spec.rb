require 'rails_helper'

RSpec.describe 'Tasks', type: :system, js: true do
  describe 'order test in index' do
    before(:all) do
      create(:user)
      create_list(:task, 4)
    end

    before(:each) do
      visit login_path
      fill_in 'メールアドレス', with: 'test@test.com'
      fill_in 'パスワード', with: '123456'
      click_button 'ログイン'
    end

    after(:all) do
      Task.destroy_all
      User.find(1).destroy
    end

    subject do
      task = all('h5')
      task_0 = task[0]
    end

    context 'by default' do
      it 'sort by created_at' do
        expect(subject).to have_content "テスト4"
        save_and_open_page
      end
    end

    context 'click 期限順' do
      it 'sort by deadline' do
        click_on '期限順'
        expect(subject).to have_content "テスト1"
        save_and_open_page
      end
    end
  end

  describe 'search test in index' do

    before(:all) do
      create(:user)
      create_list(:task, 3, name: "テストA")
      create_list(:task, 3, :in_progress, name: "テストB")
      create_list(:task, 3, :completed, name: "テストC")
    end

    before(:each) do
      visit login_path
      fill_in 'メールアドレス', with: 'test@test.com'
      fill_in 'パスワード', with: '123456'
      click_button 'ログイン'
    end

    after(:all) do
      Task.destroy_all
      User.find(1).destroy
    end

    subject! do
      fill_in 'q[name_cont]', with: task_name
      choose status
      click_button '検索'
    end

    context 'search by name' do
      let(:task_name) { 'テストA' }
      let(:status) { 'q_status_eq_' }

      it 'displays correct result' do
        expect(page).to have_content "テストA"
        save_and_open_page
      end
    end

    context 'search by status' do
      let(:task_name) { '' }
      let(:status) { 'q_status_eq_1' }

      it 'displays correct result' do
        expect(page).to have_content '着手中'
        save_and_open_page
      end
    end

    context 'search by name and status' do
      let(:task_name) { 'テストC' }
      let(:status) { 'q_status_eq_2' }

      it 'displays correct result' do
        expect(page).to have_content "テストC"
        expect(page).to have_content '完了'
        save_and_open_page
      end
    end
  end
end
