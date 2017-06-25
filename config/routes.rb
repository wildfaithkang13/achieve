Rails.application.routes.draw do
<<<<<<< HEAD
  
=======
>>>>>>> 86c0d6a2f261c85091f30297c2b2b23311003ea3
  devise_for :users
  #routerの役割メモ
  #HTTPリクエストのメソッドのURLと種類で判別する
  #GET =>ユーザーからのURLを入力してアクセスするとGETメソッド
  #フォームで入力して送信するとPOSTメソッドです。
  #form_for文は内部仕様としてPOSTでリクエストを送信する

  #get 'contacts' => 'contacts#new'
  #正常に動くパターン
  resources :contacts, only: [:index, :new, :create, :edit, :update, :destroy] do
    collection do
      post :confirm
    end
  end
  

  #rubyのコーディングルールとしてコントローラ名の複数形で記述すること
  # resources :コントローラ名s
  #resources :contacts
  #=>resouresを定義することでget XXXの記載は不要となる

  #get 'blogs' => 'blogs#index' #<<<<<この行を追加する
  resources :blogs, only: [:index, :new, :create, :edit, :update ,:destroy] do
    collection do
      post :confirm
    end
  end
    
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  
  #root 'コントローラ名#アクション名'とすることでルート・ディレクトリで
  #どのアクションを実行するかを設定することができます。
  root 'top#index'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
end
