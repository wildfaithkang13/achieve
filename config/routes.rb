Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  #devise_for :users
  #routerの役割メモ
  #HTTPリクエストのメソッドのURLと種類で判別する
  #GET =>ユーザーからのURLを入力してアクセスするとGETメソッド
  #フォームで入力して送信するとPOSTメソッドです。
  #form_for文は内部仕様としてPOSTでリクエストを送信する

  #get 'contacts' => 'contacts#new'
  resources :contacts, only: [:index, :new, :create, :edit, :update, :destroy] do
    collection do
      post :confirm
    end
  end


  #rubyのコーディングルールとしてコントローラ名の複数形で記述すること
  # resources :コントローラ名s
  #resources :contacts
  #=>resouresを定義することでget XXXの記載は不要となる
  resources :blogs do
    resources :comments
    post :confirm, on: :collection
  end

  resources :poems, only: [:index, :edit, :show]

  #root 'コントローラ名#アクション名'とすることでルート・ディレクトリで
  #どのアクションを実行するかを設定することができます。
  root 'top#index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

end
