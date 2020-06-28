class Task < ApplicationRecord
  enum priority: { low: 0, middle: 1, high: 2 }
  
  validates :name, presence: true
end
