class Task < ApplicationRecord
  validates :task_name, presence: true, length: { maximum: 15 }
  validates :task_detail, presence: true, length: { maximum: 255 }
  validates :status, presence: true
  enum status: {
    not_started_yet: 0,
    under_start: 1,
    completion: 2
    }
end
