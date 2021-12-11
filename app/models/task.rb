class Task < ApplicationRecord
  validates :task_name, presence: true, length: { maximum: 15 }
  validates :task_detail, presence: true, length: { maximum: 255 }
  validates :status, presence: true
  validates :priority, presence: true
  belongs_to :user
  has_many :labellings, dependent: :destroy
  has_many :labels, through: :labellings
  # 自動的に推論指定いるので、source:と書く必要はない

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

    # scope :creation_date_descending, -> {order(created_at: :desc)}
    # scope :end_deadline_descending, -> {order(expired_at: :desc)}
    # scope :highest_priority, -> {order(priority: :asc)}
    scope :search_task_name, -> (params) { where('task_name LIKE ?', "%#{params}%")}
    scope :search_status, -> (params) { where(status: "#{params}")}
    scope :search_label, -> (params) { where(labels: {id: "#{params}"})}
    # scope :search_label_two, -> (params) { where(label_id: "#{params}")}
    scope :search_labels, -> (params) {
      task_ids = Labelling.where(label_id: params).pluck(:task_id)
      where(id: task_ids)
    }
    # def self.search_label_two(params)
    #   where(id: Labelling.where(label_id: "#{params}").pluck(:task_id))
    # end
end
