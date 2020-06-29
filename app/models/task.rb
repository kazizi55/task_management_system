class Task < ApplicationRecord
  enum priority: { low: 0, middle: 1, high: 2 }
  
  validates :name, presence: true
  validates :deadline, presence: true
  validates :deadline, datatime_past: true
end
