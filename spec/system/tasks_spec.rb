require 'rails_helper'

RSpec.describe 'Tasks', type: :system, js: true do
  describe 'order test in index' do
    before(:all) do
      create_list(:task, 2)
      create(:task, :middle_priority)
      create(:task, :high_priority)
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

    context 'click 優先度順' do
      it 'sort by priority' do
        click_on '優先度順'
        expect(subject).to have_content "テスト1"
        save_and_open_page
      end
    end
  end

  describe 'search test in index' do
    let(:task_name) { '' }
    let(:status) { 'q_status_eq_' }
    let(:label) { '指定なし' }

    before(:all) do
      create_list(:task, 3, name: "テストA")
      create_list(:task, 3, :in_progress, name: "テストB")
      create_list(:task, 3, :completed, name: "テストC")
      create(:label)
      create_list(:label_task, 3)
    end

    before(:each) do
      visit tasks_path
    end

    after(:all) do
      LabelTask.destroy_all
      Task.destroy_all
      Label.destroy_all
    end

    subject! do
      fill_in 'q[name_cont]', with: task_name
      choose status
      select label, from: "q_labels_id_eq"
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

    context 'search by label' do
      let(:label) { 'ラベル1' }

      it 'displays correct result' do
        expect(page).to have_content "テストA"
        save_and_open_page
      end
    end
  end
end
