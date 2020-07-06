class Task < ApplicationRecord
  enum status: { not_started: 0, in_progress: 1, completed: 2 }
  
  belongs_to :user

  validates :name, presence: true
  validates :deadline, presence: true
  validates :deadline, datatime_past: true
end
