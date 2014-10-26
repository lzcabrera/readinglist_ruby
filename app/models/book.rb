class Book < ActiveRecord::Base

  has_many :book_genres
  has_many :genres, through: :book_genres

  #scope :finished, ->{ where('finished_on IS NOT NULL') }
  scope :finished, ->{ where.not(finished_on: nil) }
  scope :recent, ->{ where('finished_on > ?', 2.days.ago) }
  scope :search, ->(keyword){ where('keywords LIKE ?', "%#{keyword.downcase}%") if keyword.present? }
  scope :filter, ->(name){ joins(:genres).where('genres.name = ?', name ) }

  # def self.recent
  #   where('finshed_on > ?', 2.days.ago)
  # end

  # def self.search(keyword)
  #   if keyword.present?
  #     where(title: keyword)
  #   else
  #     all
  #   end
  # end

  before_save :set_keywords

  def finished?
    finished_on.present?
  end

  protected
    def set_keywords
      self.keywords = [title, author, description].map(&:downcase).join(' ')
    end

end
