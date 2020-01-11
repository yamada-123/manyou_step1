require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do

   describe 'タスク一覧画面' do   
    context 'タスクを作成した場合' do
      it '作成済みのタスクが表示されること'  do
        @user = FactoryBot.create(:user)
        @user2 = FactoryBot.create(:second_user)
        save_and_open_page
        visit new_session_path
        #user1でログイン
        fill_in 'session_email', with:"yamada1@gmail.com"
        fill_in 'session_password', with:"123456"
        #binding.pry
        click_on 'Log in'
        @task = FactoryBot.create(:task, user:@user)
        save_and_open_page
        @task2 = FactoryBot.create(:second_task, user: @user)
        save_and_open_page
        visit tasks_path
        #binding.pry
        expect(page).to have_content @task.title
        #binding.pry
      end
    end
    context '複数のタスクを作成した場合' do
      it 'タスクが作成日時の降順に並んでいること' do
        @user = FactoryBot.create(:user)
        @user2 = FactoryBot.create(:second_user)
        save_and_open_page
        visit new_session_path

        fill_in 'session_email', with:"yamada1@gmail.com"
        fill_in 'session_password', with: "123456"
        click_on 'Log in'
        @task = FactoryBot.create(:task, user: @user)
        save_and_open_page
        @task2 = FactoryBot.create(:second_task, user: @user)
        save_and_open_page
        visit tasks_path
        #binding.pry
        task_list = all('.task_row')  #タスク一覧を配列として取得するためview側でidを振っておく
        #binding.pry
        #indexviewにあるクラス
        save_and_open_page
        #binding.pry
        expect(task_list[0]).to have_content @task2.title
        expect(task_list[1]).to have_content @task.title
      end
    end
    context '終了期限のソートボタンを押した場合' do
      it '終了期限が降順に並んでいること' do
        @user = FactoryBot.create(:user)
        @user2 = FactoryBot.create(:second_user)
        save_and_open_page
        visit new_session_path
        fill_in 'session_email', with:"yamada1@gmail.com"
        fill_in 'session_password',with:"123456"
        click_on 'Log in'
        @task = FactoryBot.create(:task, user: @user)
        @task2 = FactoryBot.create(:second_task, user: @user)
        save_and_open_page
        visit tasks_path
        #binding.pry
        click_on '終了期限でソートする'
        page.find("#task-show-#{@task.id}").click
        # binding.pry
        expect(page).to have_content @task.title && @task.content && @task.deadline
        expect(page).not_to have_content @task2.title && @task2.content && @task2.deadline
      end
    end
    context 'タイトルが空および、状態が未着手で検索ボタンを押した場合' do
      it '状態が未着手のデータだけ表示されているようにすること' do
        @user = FactoryBot.create(:user)
        @user2 = FactoryBot.create(:second_user)
        save_and_open_page
        visit new_session_path
        fill_in 'session_email', with:"yamada1@gmail.com"
        fill_in 'session_password',with:"123456"
        click_on 'Log in'
        @task = FactoryBot.create(:task, user: @user)
        @task2 = FactoryBot.create(:second_task, user: @user)
        save_and_open_page
        visit tasks_path
        task_title = "Factoryで作ったタイトル1"
        #task_content = "Factoryで作ったコンテント1"
        #task_deadline = "2019-07-10"
        task_status = "未着手"
        #priority = "1"
        #binding.pry
        click_on '検索'
        #binding.pry
        #binding.pry
        expect(page).to have_content @task.title && @task.content && @task.deadline && @task.status && @task.priority
      end
    end
    context '優先度を高い順にソートするボタンを押した場合' do
      it '上から高→中→低の順に表示されるようにすること' do
        visit tasks_path
        #binding.pry
        click_on '優先度を高い順にソートする'
        #binding.pry
        
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
       # binding.pry
        # click_on '詳細を確認する'
        page.find("#task-show-#{@task.id}").click
        # visit  task_path(@task.id)
        expect(page).to have_content @task.title && @task.content
        expect(page).not_to have_content @task2.title && @task2.content
    end
  end
end

end
