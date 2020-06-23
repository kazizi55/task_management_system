class Task < ApplicationRecord
    validates :deadline, presence: true
    validate :deadline_cannot_be_in_the_past

    def deadline_cannot_be_in_the_past
    errors.add(:deadline, "は過去の日時は選択できません") if deadline < Time.now
    end
end
