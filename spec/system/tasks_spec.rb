require 'rails_helper'

RSpec.describe 'Tasks', type: :system, js: true do
    it "作成日時の順番で並び替えができていること" do
        Task.destroy_all
        Task.create(id: 1, name: 'テスト1', explanation: 'hi')
        Task.create(id: 2, name: 'テスト2', explanation: 'hihi2', created_at: Time.current + 1.days)
        Task.create(id: 3, name: 'テスト3', explanation: 'hihi3', created_at: Time.current + 2.days)
        Task.create(id: 4, name: 'テスト4', explanation: 'hihi4', created_at: Time.current + 3.days)
        visit tasks_path
        task = all('h2')
        task_0 = task[0]
        expect(task_0).to have_content "テスト4"
        save_and_open_page
    end
end