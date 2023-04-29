class CreateCommentJob < ApplicationJob
  queue_as :default

  def perform(data)
    p data.to_h
    comment = Comment.new
    comment.commentable_type = data["commentable_type"]
    comment.commentable_id = data["commentable_id"]
    comment.subscriber_id = data["subscriber_id"]
    comment.content = data["content"]
    comment.approved = data["approved"]
    comment.save
  end
end
