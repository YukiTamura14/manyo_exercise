# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    name { 'テストを書く' }
    detail { 'RSpec & Capybara & FactoryBotを準備する' }
    expired_at { '2019-12-31' }
    status { '完了' }
    priority { '高' }
    user
  end
end
