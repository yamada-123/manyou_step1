class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  paginates_per 3
end
