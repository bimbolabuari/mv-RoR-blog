class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :posts, dependent: :delete_all, foreign_key: 'author_id', class_name: 'Post'
  has_many :comments, dependent: :delete_all, foreign_key: 'author_id', class_name: 'Comment'
  has_many :likes, dependent: :delete_all, foreign_key: 'author_id', class_name: 'Like'

  def self.recent_posts(user)
    Post.joins(:author).where(author: { id: user.id }).order(created_at: :desc).limit(3)
  end
end
