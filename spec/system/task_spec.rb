require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  before do
    @task = FactoryBot.create(:task)
    @task2 = FactoryBot.create(:second_task)
    # binding.pry
  end
 
   describe 'タスク一覧画面' do   
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること'  do
        visit tasks_path
        expect(page).to have_content @task.title
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいること' do
        #new_task = FactoryBot.create(:task, title: 'new_task')
        visit tasks_path
        task_list = all('.task_row')
        save_and_open_page
        expect(task_list[0]).to have_content @task2.title
        expect(task_list[1]).to have_content @task.title
      end
    end
  end

  describe 'タスク登録画面' do
    context '必要項目を入力して、createボタンを押した場合' do
      it 'データが保存されること' do
      visit new_task_path
      task = FactoryBot.create(:task, title: 'task-title010103', content: 'task-title010102')
      click_on '登録する'
      visit task_path(task.id)

      expect(page).to have_content task.title && task.content
      end
    end
  end

  describe 'タスク詳細画面' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示されたページに遷移すること' do
        visit tasks_path
        # click_on '詳細を確認する'
        page.find("#task-show-#{@task.id}").click
        # visit  task_path(@task.id)
        expect(page).to have_content @task.title && @task.content
        expect(page).not_to have_content @task2.title && @task2.content
    end
  end
end


end
