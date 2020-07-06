require 'rails_helper'

RSpec.describe 'Tasks', type: :system, js: true do
  describe 'order test in index' do
    before(:all) do
      create_list(:task, 4)
    end

    before(:each) do
      visit tasks_path
    end

    after(:all) do
      Task.destroy_all
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
      create_list(:task, 3, name: "テストA")
      create_list(:task, 3, :in_progress, name: "テストB")
      create_list(:task, 3, :completed, name: "テストC")
    end

    before(:each) do
      visit tasks_path
    end

    after(:all) do
      Task.destroy_all
    end

    subject do
      fill_in 'q[name_cont]', with: task_name
      choose status
      click_button '検索'
    end

    context 'search by name' do
      let(:task_name) { 'テストA' }

      it 'displays correct result' do
        expect(page).to have_content "テストA"
        save_and_open_page
      end
    end

    context 'search by status' do
      let(:status) { 'q_status_eq_1' }

      it 'displays correct result' do
        expect(page).to have_content '状態：着手中'
        save_and_open_page
      end
    end

    context 'search by name and status' do
      let(:task_name) { 'テストC' }
      let(:status) { 'q_status_eq_2' }

      it 'displays correct result' do
        expect(page).to have_content "テストC"
        expect(page).to have_content '状態：完了'
        save_and_open_page
      end
    end
  end
end
