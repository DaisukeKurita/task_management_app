class Task < ApplicationRecord
  validates :task_name, presence: true, length: { maximum: 15 }
  validates :task_detail, presence: true, length: { maximum: 255 }
  validates :status, presence: true
  validates :priority, presence: true

  enum status: {
    not_started_yet: 0,
    under_start: 1,
    completion: 2
    }
  enum priority: {
    high: 0,
    medium: 1,
    low: 2
    }

    scope :creation_date_descending, -> {order(created_at: :desc)}
    scope :end_deadline_descending, -> {order(expired_at: :desc)}
    scope :highest_priority, -> {order(priority: :asc)}
    scope :search_task_name, ->(params) { where('task_name LIKE ?', "%#{params}%")}
    scope :search_status, ->(params) { where(status: "#{params}")}
end
