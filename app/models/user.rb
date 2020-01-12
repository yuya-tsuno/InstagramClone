class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }

  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  
  has_secure_password
  validates :password, presence: true, length: { minimum: 4 }

  mount_uploader :image, ImageUploader
  validates :image, presence: true

  # validates :age, presence: true

  # validates :sex, presence: true

  # validates :address, presence: true

  has_many :feeds
  has_many :favorites, dependent: :destroy

end
