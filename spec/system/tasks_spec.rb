require 'rails_helper'

RSpec.describe 'Tasks', type: :system, js: true do
  describe 'order test in index' do
    Task.destroy_all # 順番の正しさをタスク名で判断するため、全タスクを削除
    Task.create(id: 1, name: 'テスト1', explanation: 'hi', deadline: Time.current.tomorrow)
    Task.create(id: 2, name: 'テスト2', explanation: 'hihi2', deadline: Time.current + 2.days, created_at: Time.current + 1.days)
    Task.create(id: 3, name: 'テスト3', explanation: 'hihi3', deadline: Time.current + 3.days, created_at: Time.current + 2.days)
    Task.create(id: 4, name: 'テスト4', explanation: 'hihi4', deadline: Time.current + 4.days, created_at: Time.current + 3.days)

    before do
      visit tasks_path
    end

    context 'by default' do
      it 'sort by created_at' do
        task = all('h2')
        task_0 = task[0]
        expect(task_0).to have_content "テスト4"
        save_and_open_page
      end
    end

    context 'click 期限順' do
      it 'sort by created_at' do
        click_on '期限順'
        task = all('h2')
        task_0 = task[0]
        expect(task_0).to have_content "テスト1"
        save_and_open_page
      end
    end
  end
end