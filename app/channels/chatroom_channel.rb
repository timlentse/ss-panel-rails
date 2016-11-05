# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chatroom"
  end

  def unsubscribed
    stop_all_streams
  end

  def send_comment(data)
    comment = UserComment.create(content: data["content"], user_id: current_user.id, avatar: current_user.avatar.url(:thumb), user_name: current_user.user_name)
    MessageRelayJob.perform_later(comment)
  end

end
