# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  released_at :datetime
#  avatar      :string
#  genre_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Movie < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :genre

  delegate :name, to: :genre, allow_nil: true, prefix: true
end
