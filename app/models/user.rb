class User < ApplicationRecord
  has_secure_password

  has_many :books, dependent: :destroy
  has_many :sessions, dependent: :destroy

  has_one_attached :profile_image

  validates :name,
            presence: true,
            uniqueness: true,
            length: { minimum: 2, maximum: 20 }

  validates :introduction, length: { maximum: 50 }

  def email_address
    self[:email_address].presence || email
  end

  def email_address=(value)
    self[:email_address] = value
    self.email = value
  end
end