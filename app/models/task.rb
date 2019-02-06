class Task < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true
  validates :expired_at, presence: true

  belongs_to :user
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings, source: :label, inverse_of: :tasks

  scope :recent, -> { order(created_at: :desc) }
  scope :sort_expired, -> { order(expired_at: :desc) }
  scope :sort_priority, -> { order(priority: :asc) }

  scope :title_search, -> (task_name) { where("name LIKE ?", "%#{ task_name }%") }
  scope :status_search, -> (status) { where(status: status) }

  scope :search_label, -> (label_id) {
    task_ids = Labelings.where(label_id: label_id).pluck(:task_id)
    where(id: task_ids)
  }

  enum status: { 未着手: 1, 着手中: 2, 完了: 3 }
  enum priority: { 高: 1, 中: 2, 低: 3 }

  paginates_per 10
end
