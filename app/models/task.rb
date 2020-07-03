class Task < ApplicationRecord
  has_many :label_tasks, dependent: :destroy
  has_many :labels, through: :label_tasks

  accepts_nested_attributes_for :label_tasks, allow_destroy: true

  validates :name, presence: true
  validates :deadline, presence: true
  validates :deadline, datatime_past: true
end
