class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @messages = @conversation.messages
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end

    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end

    if @messages.last
      if @messages.last.user_id != current_user.id
        @messages.last.read = true
      end
    end
    @message = @conversation.messages.build
  end

  def create
    #紐付いているものに対してbuildでインスタンスを生成する
    # @message = @conversation.messages.new(message_params)



    #***** Message.new(message_params)を使用した場合(正しくない実装)******
    #conversation_idはもともと設定されており、
    #紐付いたメッセージを作成する(message_paramsにはmessage_idが設定される)
    #conversation_idをひも付けようとするがMessageテーブルにconversation_idの
    #カラムは存在しない、
    #Message.new(message_params)をすると会話に紐付いた値を取得できない
    #また紐付いた会話に対するメッセージIDが作成できない。(INSERTが失敗する)
    #つまりDBエラーが発生する。
    #結果としてPOSTのredirectのアクションが実行される
    #つまりリクエスト先はmessages#createとなる
    #@message = Message.new(message_params)

    #@message = @conversation.messages.new(message_params)を使用した場合(正しい実装)
    #会話に紐付いたインスタンスを生成する。
    #@message = @conversation.messages.new(message_params)
    #上記1文の実行イメージとしては入力フォームした箱が作成される
    #入力した情報をsaveする。insertが成功する
    #成功してGETアクションが実行される
    #つまりmessage#indexがリクエスト先となる
    @message = @conversation.messages.new(message_params)

    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :user_id)
  end
end
