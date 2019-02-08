require 'rails_helper'

describe "タスク管理機能", type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', detail: '最初の詳細', expired_at: '2018-12-31', status: '未着手', priority: '高', user: user) }
  let!(:task_b) { FactoryBot.create(:task, name: '二番目のタスク', detail: '二番目の詳細', expired_at: '2018-12-24', status: '着手中', priority: '中', user: user) }
  let!(:task_c) { FactoryBot.create(:task, name: '三番目のタスク', detail: '三番目の詳細', expired_at: '2018-12-16', status: '完了', priority: '中', user: user) }
  let!(:task_d) { FactoryBot.create(:task, name: '四番目のタスク', detail: '四番目の詳細', expired_at: '2019-01-01', status: '完了', priority: '低', user: user) }

  before do
    visit login_path
    fill_in 'Email', with: 'test1@example.com'
    fill_in 'Password', with: 'password'
    click_button 'ログインする'
    expect(page).to have_content "テストユーザータスク一覧"
  end

  describe 'タスク作成のテスト' do
    before do
      visit new_task_path
      fill_in 'タスク名', with: '夕ご飯の買い物'
      fill_in '詳しい内容', with: '玉ねぎ'
      fill_in '終了期限', with: '2019-02-28'
      click_on '登録する'
    end
  # save_and_open_page
  it '作成したタスクが表示される' do
    expect(page).to have_content '夕ご飯の買い物'
    expect(page).to have_content '玉ねぎ'
  end
  end

  describe 'タスク一覧のテスト' do
    before do
      visit tasks_path
    end
    # save_and_open_page
    it '作成したタスク一覧が表示される' do
      expect(page).to have_content '最初のタスク'
      expect(page).to have_content '最初の詳細'
    end
  end

  describe 'タスク詳細のテスト' do
    before do
      visit task_path(task_b)
    end

    it '作成したタスクの詳細が表示される' do
      expect(page).to have_content '二番目のタスク'
      expect(page).to have_content '二番目の詳細'
    end
  end

  describe 'タスクが作成日時の降順に並んでいるかのテスト' do
    let(:tasks) { page.all('tbody tr') }
    before do
      visit tasks_path
    end

    it '新しいタスクが一番上に表示される' do
      expect(tasks[0]).to have_content '四番目のタスク'
      expect(tasks[1]).to have_content '三番目のタスク'
      expect(tasks[2]).to have_content '二番目のタスク'
      expect(tasks[3]).to have_content '最初のタスク'
    end
  end

  describe '終了期限の降順で並んでいるテスト' do
    let(:tasks) { page.all('tbody tr') }
    before do
      visit tasks_path
      # save_and_open_page
      click_link '終了期限'
      sleep 1
    end
    it '終了期限の降順で表示される' do
      expect(tasks[0]).to have_content '2019-01-01'
      expect(tasks[1]).to have_content '2018-12-31'
      expect(tasks[2]).to have_content '2018-12-24'
      expect(tasks[3]).to have_content '2018-12-16'
    end
  end

  describe '優先度順で並んでいるテスト' do
    let(:tasks) { page.all('tbody tr') }
    before do
      visit tasks_path
      click_link '優先度'
      sleep 1
    end
    it '優先度の高い順で表示される' do
      expect(tasks[0]).to have_content '高'
      expect(tasks[1]).to have_content '中'
      expect(tasks[2]).to have_content '中'
      expect(tasks[3]).to have_content '低'
    end
  end
end