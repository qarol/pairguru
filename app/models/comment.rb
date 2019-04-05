class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :content, presence: true
  validates :user, uniqueness: { scope: :movie, message: :already_commented }

  scope :last_7_days, -> { where(arel_table[:created_at].gt(7.days.ago.beginning_of_day)) }

  delegate :email, to: :user, allow_nil: true, prefix: true
end
