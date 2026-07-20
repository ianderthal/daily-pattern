class Event < ApplicationRecord
  validates :date, presence: true
  validates :time, presence: true
  validates :comment, length: { maximum: 500 }
end
