class Task < ApplicationRecord
  validates :name, presence: true
  validates :deadline, presence: true
  validates :deadline, datatime_past: true
end
