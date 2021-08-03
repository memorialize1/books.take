class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :book
  validates :com, presence: true
end
