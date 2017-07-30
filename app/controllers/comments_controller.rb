class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :destroy, :update,:show]
  def create
    # Blogをパラメータの値から探し出し,Blogに紐づくcommentsとしてbuildします。
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    @notification = @comment.notifications.build(user_id: @blog.user.id)
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        #format.htmlは非同期通信ができてない時に呼び出される
        format.html { redirect_to blog_path(@blog), notice: 'コメントを投稿しました。' }
        flash.now[:message] = "コメントを投稿しました！"
        format.js { render :index  }
        unless @comment.blog.user_id == current_user.id
          Pusher.trigger("user_#{@comment.blog.user_id}_channel", 'comment_created', {
            message: 'あなたの作成したブログにコメントが付きました'
          })
        end
          Pusher.trigger("user_#{@comment.blog.user_id}_channel", 'notification_created', {
            unread_counts: Notification.where(user_id: @comment.blog.user.id, read: false).count
          })
        else
        format.html { render :new }
      end
    end
  end
  def edit
    #どのブログの情報かを取得。
    @blog = @comment.blog
  end
  def update
    #binding.pry
    if @comment.update(comment_params)
      redirect_to blog_path(@comment.blog), notice: "コメントを更新しました"
    else
      render 'edit'
    end
  end

  def show
    @blog = @comment.blog
    render 'index'
  end
  #_をつけたファイルは共通部品。呼び出す時はrenderを使う
  def destroy
    @comment.destroy
    flash.now[:message] = "コメントを削除しました！"
    #renderで非同期通信となる
    render 'index'
  end
  private
    def comment_params
      params.require(:comment).permit(:blog_id, :content)
    end
    def set_comment
      #ブログのどのコメントの情報かを取得する
      @comment=Comment.find(params[:id])
    end
end
