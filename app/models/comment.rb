class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def self.update_comment_counter(post)
    count = Comment.where("post_id = #{post.id}").count
    post.comments_counter = count
    post.save
  end
end
