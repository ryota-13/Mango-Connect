class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :post

  validates :content, presence: true, length: { maximum: 200, message: "は200文字以内で入力してください" }
  
end
