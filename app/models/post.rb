class Post < ApplicationRecord
  belongs_to :user
  
  has_many :comments, dependent: :destroy
  
  has_many :favorites, dependent: :destroy

  has_one_attached :image

  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 200 }

  def self.search_for(content, method)
    if method == 'perfect'
      Post.where('title = ?', content)
    elsif method == 'forward'
      Post.where('title LIKE ?', content + '%')
    elsif method == 'backward'
      Post.where('title LIKE ?', '%' + content)
    else
      Post.where('title LIKE ?', '%' + content + '%')
    end
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  scope :latest, -> { order(created_at: :desc) }
  scope :old, -> { order(created_at: :asc) }
  scope :most_favorited, -> { left_joins(:favorites).group(:id).order('COUNT(favorites.id) DESC') }

  

end
