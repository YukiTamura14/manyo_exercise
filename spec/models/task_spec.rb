# frozen_string_literal: true

require 'rails_helper'

describe 'タスクモデル機能', type: :model do
  let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', detail: '最初の詳細', expired_at: '2018-12-31', status: '未着手', priority: '高') }
  let!(:task_b) { FactoryBot.create(:task, name: '二番目のタスク', detail: '二番目の詳細', expired_at: '2018-12-24', status: '着手中', priority: '中') }
  let!(:task_c) { FactoryBot.create(:task, name: '三番目のタスク', detail: '三番目の詳細', expired_at: '2018-12-16', status: '完了', priority: '中') }
  let!(:task_d) { FactoryBot.create(:task, name: '四番目のタスク', detail: '四番目の詳細', expired_at: '2019-01-01', status: '完了', priority: '低') }

  describe 'バリデーションのテスト' do
    it 'nameが空ならバリデーションが通らない' do
      task = Task.new(name: '', detail: '失敗テスト')
      expect(task).not_to be_valid
    end

    it 'detailが空ならバリデーションが通らない' do
      task = Task.new(name: '失敗テスト', detail: '')
      expect(task).not_to be_valid
    end

    it 'nameとdetailに内容が記載されていればバリデーションが通る' do
      task = Task.new(name: '', detail: '')
      expect(task).not_to be_valid
    end
  end

  describe '検索機能のテスト' do
    it 'title_searchのテスト' do
      expect(Task.title_search('最初のタスク')).to include(Task.find_by(name: '最初のタスク'))
      expect(Task.title_search('タスク').count).to eq(4)
    end

    it 'status_searchのテスト' do
      expect(Task.status_search('着手中')).to include(Task.find_by(name: '二番目のタスク'))
      expect(Task.status_search('完了').count).to eq(2)
    end
  end
end
