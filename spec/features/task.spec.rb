require 'rails_helper'


#「タスク一覧画面に遷移したら、作成済みのタスクが表示される」
#「タスク登録画面で、必要項目を入力してcreateボタンを押したらデータが保存される」
#「任意のタスク詳細画面に遷移したら、該当タスクの内容が表示されたページに遷移する」
RSpec.feature "タスク管理機能", type: :feature do
  scenario "タスク作成のテスト" do
    visit new_task_path
    fill_in 'Name', with: '夕ご飯の買い物'
    fill_in 'Detail', with: '玉ねぎ'
    click_on 'Create Task'

    # save_and_open_page
    expect(page).to have_content '夕ご飯の買い物'
    expect(page).to have_content '玉ねぎ'
  end

  scenario "タスク一覧のテスト" do
    Task.create!(name: 'test_task_01', detail: 'testtesttest')
    Task.create!(name: 'test_task_02', detail: 'samplesample')
    visit tasks_path

    # save_and_open_page
    expect(page).to have_content 'testtesttest'
    expect(page).to have_content 'samplesample'
  end

  scenario "タスク詳細のテスト" do
    task = Task.create!(name: 'test_task_01', detail: 'testtesttest')
    visit tasks_path
    click_link '詳細', href: task_path(task)
    save_and_open_page
    expect(page).to have_content 'testtesttest'
  end
end
