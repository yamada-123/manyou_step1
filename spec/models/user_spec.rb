require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザーテスト' do
    context '管理者がタスクを抱えているユーザーを削除した場合' do
      it 'タスクも一緒に削除されていることを確認する' do
        @user = FactoryBot.create(:user)
        @user2 = FactoryBot.create(:second_user)
        @task = FactoryBot.create(:task, user: @user2)
        expect(@task).to be_valid
        #binding.pry
        User.destroy(2)
        
        #binding.pr
        #expect { @user2.destroy }.to change { @task.count }.by(-1)
        #expect(Task.all.count).not_to be_valid
        #expect{@user2.destroy}.to change {Task.count}
        #it { expect(@user2).to have_many(:tasks).dependent(:destroy) }
        expect(Task.all).not_to include @task
      end
    end
  end
end
