class Book < ActiveRecord::Base

  has_many :book_genres
  has_many :genres, through: :book_genres

  #scope :finished, ->{ where('finished_on IS NOT NULL') }
  scope :finished, ->{ where.not(finished_on: nil) }
  scope :recent, ->{ where('finished_on > ?', 2.days.ago) }

  # def self.recent
  #   where('finshed_on > ?', 2.days.ago)
  # end

  def finished?
    finished_on.present?
  end
end
