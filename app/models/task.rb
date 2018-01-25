class Task < ApplicationRecord
  belongs_to :user

  validates :task, presence: true
end
