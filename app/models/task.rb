class Task < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true
  validates :expired_at, presence: true
  scope :recent, -> { order(created_at: :desc) }
  scope :sort_expired, -> { order(expired_at: :desc) }
end
