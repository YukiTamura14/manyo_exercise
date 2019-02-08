require 'rails_helper'

describe "ユーザー管理機能", type: :system do
  describe 'ユーザー作成のテスト' do
    let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com', admin: true)}
    let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com')}
    let!(:task_a) { FactoryBot.create(:task, name: 'Aのタスク', user: user_a) }

    before do
      visit login_path
      fill_in 'Email', with: login_user.email
      fill_in 'Password', with: login_user.password
      click_button 'ログインする'
    end

    context 'ユーザーAがログインしているとき' do
      let(:login_user){ user_a }
      it '作成したタスクが表示される' do
        expect(page).to have_content "Aのタスク"
      end
    end

    context 'ユーザーBがログインしているとき' do
      let(:login_user){ user_b }

      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).to have_no_content "Aのタスク"
      end
    end

    context '他ユーザーの詳細画面を開こうとしたとき' do
      let(:login_user){ user_a }

      it 'root_pathにリダイレクトされる' do
        visit user_path(user_b.id)
        expect(page).to have_content 'タスク一覧'
        expect(page).to have_no_content 'a詳細'
      end
    end
  end
end
