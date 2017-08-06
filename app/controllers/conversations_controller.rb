class ConversationsController < ApplicationController
  def index
    @users = User.all
    @conversations = Conversation.all
  end

  def create
    #送ったユーザーと受け取ったユーザーに関係性があるか？を判定
    #例：
    #松本 => 金井　メッセージを送信
    # 松本 => sender_idに松本さんのユーザーIDが設定される
    # 金井 => recipient_idに自分のユーザーIDが設定される
    # idは違うけど、二人の会話は成立しているため関係性がある
    #よってif文ではtrueを返す
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
