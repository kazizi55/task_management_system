class Task < ApplicationRecord
  enum status: { not_started: 0, in_progress: 1, completed: 2 }

  validates :name, presence: true
end
