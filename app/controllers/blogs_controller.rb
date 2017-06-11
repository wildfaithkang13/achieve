class BlogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blog, only: [:edit, :update, :destroy]
  
  def index #呼び出されるのはindex.html.erb
    @blogs = Blog.all
  end
  
  def new #呼び出されるのはnew.html.erb
    if params[:back]
      @blog = Blog.new(blogs_params)
    else
      @blog = Blog.new
    end
  end
  
  def confirm
    @blog = Blog.new(blogs_params)
    render :new if @blog.invalid?
  end
  
  

  def create #呼び出されるのはcreate.html.erb
  #アクションが切り替わるとインスタンス変数はリセット(初期化)される
  #定義自体がなくなる
  
  #moedlの情報と入力した情報の2つが必要であるため
  #modelがCRUDをするのでmodelに指示を必要があるためインスタンスを生成する必要がある
  #@blog = Blog.new
  #saveメソッドはmodelに対して命令をしているメソッド。そのためblogモデルを生成しないと
  #saveメソッドが使えない。入力したものを保存したいので入力情報を取得しなければいけない
  #必要な情報を取得するためのメソッドblogs_paramsを呼び出して結果を@blogに代入する
  @blog = Blog.new(blogs_params) 
  @blog.user_id = current_user.id
  @blog.name = current_user.name
    if @blog.save
      # 一覧画面へ遷移して"ブログを作成しました！"とメッセージを表示します。
      redirect_to blogs_path, notice: "ブログを作成しました！"
    else
      # 入力フォームを再描画します。
      render 'new'
    end
  end
  
  def edit
    #findメソッドはidを引数にとって特定のレコードを取得する
    #@blog = Blog.find(params[:id])
  end
  

  def update
    # edit, update, destroyで共通コード
    @blog = Blog.find(params[:id])
    if @blog.update(blogs_params)
      redirect_to blogs_path, notice: "ブログを更新しました！"
    else
      render 'edit'
    end
  end
  
  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice: "ブログを削除しました！"
  end
  
    private
    #リクエストにパラメータ情報を取得するためのメソッド
    def blogs_params
      #リクエストパラメータの中からさらにtitleとcontentの値のみを取得する
      params.require(:blog).permit(:title, :content)
      #上記で取得した情報をmodelに渡す必要がある。
      #このメソッドを使うことで以下のような状態となる
      #(title:'ssss',content: 'aaaa' )
    end
    
    # idをキーとして値を取得するメソッド
    def set_blog
      @blog = Blog.find(params[:id])
    end

end
