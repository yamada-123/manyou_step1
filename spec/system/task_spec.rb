require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
 
  describe 'タスク一覧画面' do   
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること'  do
        task = FactoryBot.create(:task, title: 'task-title010101')
        visit tasks_path
        expect(page).to have_content task.title
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
      visit new_task_path
      task = FactoryBot.create(:task, title: 'task-title010103', content: 'task-title010102')
      click_on 'Create Task'
      visit task_path(task.id)

      expect(page).to have_content task.title && task.content
      end
    end
  end

  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移すること' do
        visit new_task_path
        task = FactoryBot.create(:task, title:'あいさつ', content: 'こんにちは')
        visit tasks_path
        click_on '詳細を確認する'
        visit  task_path(task)
        expect(page).to have_content task.title && task.content
    end
  end
end


end
