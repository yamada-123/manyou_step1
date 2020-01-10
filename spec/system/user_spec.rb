require 'rails_helper'

RSpec.describe 'User機能', type: :system do
  # before do
  #   binding.pry
  #   @user = FactoryBot.create(:user)
  #   binding.pry
  #   @user2 = FactoryBot.create(:second_user)
  #   @user3 = FactoryBot.create(:third_user)
  # end

  describe 'ユーザーテスト' do
    context 'ログインしていない時に、new_task_pathに遷移しようとした場合' do
      it 'ログイン画面が表示されるようにすること' do
        visit new_task_path
        expect(current_path).to eq (new_session_path)
      end
    end
    context 'ログイン中他人のプロフィールページを見ようとした場合' do
      it '自分のプロフィールページにリダイレクトすること' do
        visit new_session_path
        session_email = "yamada1@gmail.com"
        session_password = "123456"   
        click_on 'Log in'
        visit user_path(3) 
        binding.pry
        expect(current_path).to eq (user_path(2))    
      end
    end

  end

end