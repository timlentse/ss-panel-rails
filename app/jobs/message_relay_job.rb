class MessageRelayJob < ApplicationJob
  include ActionView::Helpers::DateHelper
  queue_as :default

  def perform(comment)
    comment_time = time_ago_in_words(comment.created_at)
    comment = {id: comment.id, content: comment.content,user_name: comment.user_name, avatar: comment.avatar,time: comment_time }
    content = ApplicationController.render(partial: 'users/comment',
                                           locals: { comment: comment  })
    ActionCable.server.broadcast "chatroom", {
      return_msg: "success",
      content: content
    }
  end
end
