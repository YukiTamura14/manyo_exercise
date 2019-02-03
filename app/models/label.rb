class Label < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  has_many :labelings, dependent: :destroy
  has_many :tasks, through: :labelings, source: :task, inverse_of: :labels

  scope :update_order, -> { order(updated_at: :desc) }
end
