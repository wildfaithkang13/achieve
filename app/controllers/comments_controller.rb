class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :destroy, :update,:show]
  def create
    # Blogをパラメータの値から探し出し,Blogに紐づくcommentsとしてbuildします。
    @comment = current_user.comments.build(comment_params)
    @blog = @comment.blog
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_path(@blog), notice: 'コメントを投稿しました。' }
        format.js { render :index }
      else
        format.html { render :new }
      end
    end
  end

  def edit
    #どのブログの情報かを取得。
    @blog = @comment.blog
  end
#binding.pryと入力するとデバッグモードとなる
#paramsと入れるとその時点でのparamの中身を取得できる
  def update
    #binding.pry
    if @comment.update(comment_params)
      #redirect_to blog_comment_path, notice: "コメントを更新しました！"
      redirect_to blog_path(@comment.blog), notice: "コメントを更新しました"
    else
      render 'edit'
    end
  end

  def show
    @blog = @comment.blog
    #redirect_to blog_comment_path(@blog, @content), notice: "テスト"
    render 'index'
  end

  #_をつけたファイルは共通部品。呼び出す時はrenderを使う

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to blog_path(@blog), notice: 'コメントを削除しました。' }
      format.js { render :index}
    end
  end

  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:blog_id, :content)
    end

    def set_comment
      #ブログのどのコメントの情報かを取得する
      @comment=Comment.find(params[:id])
    end
end
