class ContactsController < ApplicationController
  #begore_action => onlyに指定されているアクションを実行する前に行われる処理
  #以下に記載されているedit,update,destoryが行われる前にset_contactの処理が行われる
  #つまり@contact = Contact.find(params[:id])が実行されるので
  #def editにわざわざ@contact = Contact.find(params[:id])を記載する必要はなし
  before_action :set_contact, only:[:edit, :update, :destroy]
  
  def index
    @contacts = Contact.all
  end
  
  def new
    #@contact = Contact.new
    if params[:back]
      @contact = Contact.new(contacts_params)
    else
      @contact = Contact.new
    end
  end
  
  def confirm
    @contact = Contact.new(contacts_params)
    render :new if @contact.invalid?
  end
  
  def create
    @contact = Contact.new(contacts_params)
    if @contact.save
      #redirect_to blogs_path, notice: "お問い合わせありがとうございました！"
      #特定のページに戻したい場合はredirect_to GETメソッドのprefix名 + "_path"
      #redirect_to new_contact_path, notice: "お問い合わせが完了しました！"
      redirect_to root_path, notice: "お問い合わせが完了しました！"
    else
      render 'new'
    end
  end
  
  def edit
    #findメソッドはidを引数にとって特定のレコードを取得する
  end
  
  def update
    if @contact.update(contacts_params)
      redirect_to new_contact_path, notice: "お問い合わせありがとうございました！"
    else
      render 'edit'
    end
    #@contacts.update(contacts_params)
    #redirect_to new_contact_path, notice: "お問い合わせありがとうございました！"
  end
  
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy
    redirect_to new_contact_path, notice: "ブログを削除しました！"
  end
  
    private
    def contacts_params
      #requireに指定するのはモデル名をする(変数名を設定するわけではない)
      params.require(:contact).permit(:name,:email,:content)
    end
    
        # idをキーとして値を取得するメソッド
    def set_contact
      @contact = Contact.find(params[:id])
    end
end
