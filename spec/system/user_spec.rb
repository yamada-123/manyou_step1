require 'rails_helper'

RSpec.describe 'User機能', type: :system do
  #before do
    #binding.pry
    #@user = FactoryBot.create(:user)
    # #binding.pry
    # @user2 = FactoryBot.create(:second_user)
    # @user3 = FactoryBot.create(:third_user)
  #end

  describe 'ユーザーテスト' do
    context 'ログインしていない時に、new_task_pathに遷移しようとした場合' do
      it 'ログイン画面が表示されるようにすること' do
        visit new_task_path
        #binding.pry
        expect(current_path).to eq (new_session_path)
      end
    end
  end
  describe 'ユーザーテスト' do
    context 'ログイン中他人のプロフィールページを見ようとした場合' do
      it '自分のプロフィールページにリダイレクトすること' do
        # visit new_user_path
        # fill_in 'user_name',with:"山田"
        # fill_in 'user_email',with:"yamada111@gmail.com"
        # fill_in 'user_password',with:"123456"
        # fill_in 'user_password_confirmation',with:"123456"
        # # save_and_open_page
        # #binding.pry
        @user = FactoryBot.create(:user)
        save_and_open_page
        @user2 = FactoryBot.create(:second_user)
        save_and_open_page
        visit new_session_path
        fill_in 'session_email',with:"yamada1@gmail.com"
        fill_in 'session_password',with:"123456"
        click_on 'Log in'
        #binding.pry
        visit user_path(2) 
        #binding.pry
        expect(current_path).to eq (user_path(1))
      end
    end
  end
  describe 'ユーザーテスト' do
    context 'ログインした状態でtasks_pathに遷移した場合' do
      it '自分の投稿だけ表示するようにすること' do
        @user = FactoryBot.create(:user)
        @user2 = FactoryBot.create(:second_user)
        save_and_open_page
        visit new_session_path
        #user2でログイン
        fill_in 'session_email', with:"yamada2@gmail.com"
        fill_in 'session_password',with:"123456"
        click_on 'Log in'
        #binding.pry
        @task3 = FactoryBot.create(:third_task, user: @user2)
        save_and_open_page
        click_on 'Logout'

        #user1でログイン
        fill_in 'session_email', with:"yamada1@gmail.com"
        fill_in 'session_password',with:"123456"
        click_on 'Log in'
        @task = FactoryBot.create(:task, user: @user)
        save_and_open_page
        @task2 = FactoryBot.create(:second_task, user: @user)
        save_and_open_page
        visit tasks_path
        #binding.pry
        expect(page).to have_content @task.title && @task2.title 
      end
    end
  end
  describe 'ユーザーテスト' do
    context 'ログインしている時にnew_user_pathに遷移した場合' do
      it 'userのプロフィール画面に遷移すること' do
        @user = FactoryBot.create(:user)
        save_and_open_page
        visit new_session_path
        fill_in 'session_email', with:"yamada1@gmail.com"
        fill_in 'session_password', with:"123456"
        click_on 'Log in'
        visit new_user_path
        #binding.pry
        expect(current_path).to eq tasks_path
      end
    end
  end
  describe 'ユーザーテスト' do
    context '管理者ユーザー追加画面でAdd Userを押した場合' do
      it '新しいユーザーが追加されていること' do
        @user = FactoryBot.create(:user)
        save_and_open_page
        visit new_session_path
        fill_in 'session_email', with:"yamada1@gmail.com"
        fill_in 'session_password', with:"123456"
        click_on 'Log in'
        visit new_admin_user_path
        fill_in 'user_name', with:'平民'
        fill_in 'user_email',with: 'heimin@gmail.com'
        fill_in 'user_password',with: '123456'
        fill_in 'user_password_confirmation',with: '123456'
        select 'false'
        #fill_in 'user_admin',with: 'false'
        #binding.pry
        click_on 'Add user'
        visit admin_users_path
        save_and_open_page
        #binding.pry
        expect(page).to have_content '平民'
      end
    end
  end
  describe 'ユーザーテスト' do
    context '管理権限を持っていないユーザーが、new_admin_users_pathにvisitした場合' do
      it 'フォーム入力が表示されていないようにすること' do
        @user2 = FactoryBot.create(:user)
        save_and_open_page
        visit new_session_path
        fill_in 'session_email', with:"yamada2@gmail.com"
        fill_in 'session_password', with:"123456"
        click_on 'Log in'
        visit new_admin_user_path
        #binding.pry
        expect(page).not_to have_content  'user_name' && 'user_email' && 'user_password' && 'user_password_confirmation' && 'user_admin'
      end
    end
  end
  describe 'ユーザーテスト' do
    context '管理者がタスクを抱えているユーザーを削除した場合' do
      it 'タスクも一緒に削除されていることを確認する' do
        @user = FactoryBot.create(:user)
        @user2 = FactoryBot.create(:second_user)
        save_and_open_page
        visit new_session_path
        save_and_open_page
        fill_in 'session_email', with:"yamada2@gmail.com"
        fill_in 'session_password', with:"123456"
        click_on 'Log in'
        @task = FactoryBot.create(:task, user: @user2)
        save_and_open_page
        click_on 'Logout'
        visit new_session_path
        fill_in 'session_email', with:"yamada1@gmail.com"
        fill_in 'session_password', with:'123456'
        click_on 'Log in'
        visit admin_users_path
        #binding.pry
        tds = page.all('td')
        tds[15].click
        save_and_open_page
        expect(page).not_to have_content '@user2.name'
        #binding.pry
        visit tasks_path
        #binding.pry
        expect(page).not_to have_content '@task.title'
      end
    end
  end
        
end