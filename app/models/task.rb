class Task < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true
  validates :expired_at, presence: true
  # validates :status, inclusion: { in: %w(未着手 着手中 完了) }
  scope :recent, -> { order(created_at: :desc) }
  scope :sort_expired, -> { order(expired_at: :desc) }
  scope :sort_priority, -> { order(priority: :asc) }

  scope :title_search, -> (task_name) { where("name LIKE ?", "%#{ task_name }%") }
  scope :status_search, -> (status) { where(status: status) }

  enum status: { 未着手: 1, 着手中: 2, 完了: 3 }
  enum priority: { 高: 1, 中: 2, 低: 3 }
end
