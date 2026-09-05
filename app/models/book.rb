class Book < ApplicationRecord
  belongs_to :user, optional: true

  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_many :book_comments, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy

  after_create do
  user.followers.each do |follower|
    notifications.create(user_id: follower.id)
  end
end

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
  validates :score,
            presence: true,
            numericality: {
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 5
            },
            on: :create

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search, word)
    if search == "perfect_match"
      where("title LIKE ?", word)
    elsif search == "forward_match"
      where("title LIKE ?", "#{word}%")
    elsif search == "backward_match"
      where("title LIKE ?", "%#{word}")
    else
      where("title LIKE ?", "%#{word}%")
    end
  end
end