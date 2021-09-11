class Task < ApplicationRecord
  validates :task_name, presence: true, length: { maximum: 15 }
  validates :task_detail, length: { maximum: 255 }
end
