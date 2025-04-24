class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }
  validates :profile, length: { maximum: 50 }

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy 
  has_many :favorites, dependent: :destroy 
  has_many :favorited_posts, through: :favorites, source: :post

  has_many :active_relationships, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy
  has_many :followings, through: :active_relationships, source: :followed

  has_many :passive_relationships, class_name: 'Follow', foreign_key: 'followed_id', dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower 

  has_one_attached :image  

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end

  def follow(user)
    active_relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    active_relationships.find_by(followed_id: user.id)&.destroy
  end

  def following?(user)
    followings.include?(user)
  end

  def feed
    Post.where(user_id: followings.pluck(:id)) 
  end

  def self.search_for(content, method)
    case method
    when 'perfect'
      where(name: content)
    when 'forward'
      where('name LIKE ?', "#{content}%")
    when 'backward'
      where('name LIKE ?', "%#{content}")
    else
      where('name LIKE ?', "%#{content}%")
    end
  end
end

