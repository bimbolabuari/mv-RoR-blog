class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def self.update_like_counter(post)
    count = Like.where("post_id = #{post.id}").count
    post.like_counter = count
    post.save
  end
end
