require 'rails_helper'

RSpec.describe 'Tasks', type: :system, js: true do
  describe 'order test in index' do
    before(:all) do
      create_list(:task, 4)
    end

    before(:each) do
      visit tasks_path
    end

    subject do 
      task = all('h2')
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
end
