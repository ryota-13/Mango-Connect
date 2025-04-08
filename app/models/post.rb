class Post < ApplicationRecord
  belongs_to :user
  
  has_many :comments, dependent: :destroy
  
  has_many :favorites, dependent: :destroy

  has_one_attached :image

  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 200 }


end
