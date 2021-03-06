class Task < ApplicationRecord
  enum status: { not_started: 0, in_progress: 1, completed: 2 }
  enum priority: { low: 0, middle: 1, high: 2 }

  validates :name, presence: true
  validates :priority, presence: true
  validates :deadline, presence: true
  validates :deadline, datatime_past: true
end
