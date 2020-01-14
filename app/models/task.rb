class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  paginates_per 3
  belongs_to :user
  has_many :middles, dependent: :destroy
  has_many :middles_labels, through: :middles, source: :label
  
end
