# frozen_string_literal: true

require 'rails_helper'
describe 'ユーザー管理機能', type: :system do
  describe '管理者機能のテスト' do
    let!(:admin) { FactoryBot.create(:user, admin: true) }
    let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
    let(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
    let!(:task_admin) { FactoryBot.create(:task, name: 'adminのタスク', detail: 'adminのタスクの詳細', expired_at: '2018-12-31', status: '完了', priority: '高', user: admin) }
    let!(:task_b) { FactoryBot.create(:task, name: 'user_aのタスク', detail: 'user_aタスクの詳細', expired_at: '2018-12-24', status: '着手中', priority: '中', user: user_a) }
    let!(:task_c) { FactoryBot.create(:task, name: 'user_bのタスク', detail: 'user_bタスクの詳細', expired_at: '2018-12-16', status: '未着手', priority: '低', user: user_b) }

    before do
      visit root_path

      fill_in 'Email', with: 'test1@example.com'
      fill_in 'Password', with: 'password'
      click_button 'ログインする'
    end

    context 'ユーザー一覧のテスト' do
      before do
        visit admin_users_path
      end

      it 'ユーザー一覧ページが表示される' do
        expect(page).to have_content 'ユーザー一覧'
        expect(page).to have_content 'ユーザー新規登録'
        expect(page).to have_content 'ユーザーA'
        expect(page).to have_content 'ユーザーB'
      end
    end

    context 'adminによるユーザー作成のテスト' do
      before do
        visit new_admin_user_path
      end

      it '新しいユーザーが作成される' do
        fill_in 'メールアドレス', with: 'new_user@example.com'
        fill_in 'パスワード', with: 'newuser'
        fill_in 'パスワード(確認)', with: 'newuser'
        click_button 'アカウントを作成する'
      end
    end

    context 'ユーザー詳細ページのテスト' do
      before do
        visit admin_user_path(user_a.id)
      end

      it 'ユーザーAの詳細ページが表示される' do
        expect(page).to have_content '名前 ユーザーA'
        expect(page).to have_content 'メールアドレス a@example.com'
        expect(page).to have_content '管理者権限 なし'
        expect(page).to have_content 'user_aのタスク'
      end
    end

    context '管理者によるユーザー編集、更新のテスト' do
      before do
        visit edit_admin_user_path(user_b.id)
      end

      it 'user_bがuser_cに編集される' do
        fill_in '名前', with: 'user_c'
        check '管理者権限'
        fill_in 'パスワード', with: 'userc'
        fill_in 'パスワード(確認)', with: 'userc'
        click_on 'アカウントを作成する'

        expect(page).to have_content 'user_c'
        expect(page).to have_content 'あり'
      end
    end

    context '管理者によるユーザー削除のテスト' do
      before do
        visit admin_users_path
      end

      it 'user_aが一覧から削除される' do
        all('tbody tr')[1].click_link '削除'
        page.driver.browser.switch_to.alert.text.should == 'ユーザー「ユーザーA」を削除します。よろしいですか？'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_no_content 'user_a'
      end
    end
  end
end
