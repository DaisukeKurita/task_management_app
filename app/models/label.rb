class Label < ApplicationRecord
  validates :label_name, presence: true
  has_many :labellings, dependent: :destroy
  has_many :tasks, through: :labellings
  belongs_to :user
end
