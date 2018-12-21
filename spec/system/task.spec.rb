require 'rails_helper'

describe "タスク管理機能", type: :system do
  let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', detail: '最初の詳細', expired_at: '2018-12-31')}
  let!(:task_b) { FactoryBot.create(:task, name: '二番目のタスク', detail: '二番目の詳細', expired_at: '2018-12-24')}
  let!(:task_c) { FactoryBot.create(:task, name: '三番目のタスク', detail: '三番目の詳細', expired_at: '2018-12-16')}

   describe 'タスク作成のテスト' do
     before do
       visit new_task_path
       fill_in 'タスク名', with: '夕ご飯の買い物'
       fill_in '詳しい内容', with: '玉ねぎ'
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
      expect(tasks[0]).to have_content '三番目のタスク'
      expect(tasks[1]).to have_content '二番目のタスク'
      expect(tasks[2]).to have_content '最初のタスク'
    end
  end

  describe '終了期限の降順で並んでいるテスト' do
    let(:tasks) { page.all('tbody tr') }
    before do
      visit tasks_path
      click_link '終了期限でソートする'
    end
    it '終了期限の降順で表示される' do
      expect(tasks[0]).to have_content '2018-12-31'
      expect(tasks[1]).to have_content '2018-12-24'
      expect(tasks[2]).to have_content '2018-12-16'
      #save_and_open_page
    end
  end
end
