require 'rails_helper'

describe "ラベル機能", type: :system do
  let(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }

  let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', detail: '最初の詳細', expired_at: '2018-12-31', status: '未着手', priority: '高', user: user_a ) }
  let!(:task_b) { FactoryBot.create(:task, name: '三番目のタスク', detail: '三番目の詳細', expired_at: '2018-12-31', status: '未着手', priority: '高', user: user_a ) }

  let!(:label_1) { FactoryBot.create(:label, name: 'ラベル1') }
  let!(:label_2) { FactoryBot.create(:label, name: 'ラベル2') }

  let!(:labeling_1) { FactoryBot.create(:labeling, task: task_a, label: label_1) }
  let!(:labeling_2) { FactoryBot.create(:labeling, task: task_b, label: label_2) }

  before do
    visit login_path
    fill_in 'Email', with: 'a@example.com'
    fill_in 'Password', with: 'password'
    click_button 'ログインする'
    expect(page).to have_content "ユーザーAタスク一覧"
  end

  describe "ラベル一覧のテスト" do
    before do
      visit labels_path
    end

    it "作成したラベル一覧が表示される" do
      expect(page).to have_content 'ラベル1'
      expect(page).to have_content 'ラベル2'
    end
  end

  describe "ラベルの新規作成のテスト" do
    before do
      visit new_label_path
    end

    it "ラベルを作成する" do
      fill_in 'Name', with: 'ラベル3'
      click_on '登録する'

      expect(page).to have_content 'ラベル1'
      expect(page).to have_content 'ラベル2'
      expect(page).to have_content 'ラベル3'
    end
  end

  describe "ラベル編集のテスト" do
    before do
      visit edit_label_path(label_1)
    end

    it "ラベルを編集する" do
      fill_in 'Name', with: 'ラベル4'
      click_on '更新する'

      visit labels_path

      expect(page).to have_content "ラベル4"
      expect(page).to_not have_content "ラベル1"
    end
  end

  describe "ラベル検索のテスト" do
    before do
      visit tasks_path
      expect(page).to have_content '最初のタスク'
      expect(page).to have_content '三番目のタスク'
    end

    it "ラベル1がラベリングされているタスクを表示する" do
      select 'ラベル1', from: 'task_label_id'
      click_on '検索'

      expect(page).to have_content '最初のタスク'
      expect(page).to_not have_content '三番目のタスク'
    end
  end
end



