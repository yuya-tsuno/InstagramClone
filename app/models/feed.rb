class Feed < ApplicationRecord
  validates :image,  presence: true
  validates :content,  presence: true, length: { in: 1..100}
end
