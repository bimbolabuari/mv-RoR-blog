class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments
  has_many :likes

  def self.update_post_counter(user)
    count = Post.where("author_id = #{user.id}").count
    user.posts_counter = count
    user.save
  end

  def self.recent_comments(post)
    Comment.where("post_id = #{post.id}").order(created_at: :desc).limit(5)
  end
end
