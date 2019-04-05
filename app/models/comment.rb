class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :content, presence: true
  validates :user, uniqueness: { scope: :movie, message: :already_commented }

  delegate :email, to: :user, allow_nil: true, prefix: true
end
