class Task < ApplicationRecord
  validates :task_name, presence: true, length: { maximum: 15 }
  validates :task_detail, presence: true, length: { maximum: 255 }
  validates :status, presence: true
end
