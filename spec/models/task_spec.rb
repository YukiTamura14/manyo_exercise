require 'rails_helper'

describe "タスクモデル機能", type: :model do

  it "nameが空ならバリデーションが通らない" do
    task = Task.new(name: '', detail: '失敗テスト')
    expect(task).not_to be_valid
  end

  it "detailが空ならバリデーションが通らない" do
    task = Task.new(name: '失敗テスト', detail: '')
    expect(task).not_to be_valid
  end

  it "nameとdetailに内容が記載されていればバリデーションが通る" do
    task = Task.new(name: '', detail: '')
    expect(task).not_to be_valid
  end
end
