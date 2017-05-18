#ヘルパーメソッドに定義したメソッドは、どのビューからも使用できるようになる
module BlogsHelper
  #choose_new_or_editはメソッド名。別のhelperで同名のhelperを定義すると
  #param is missing or the value is emptyが発生することがあるので作成時には
  #かぶらないように注意すること
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'confirm'
      confirm_blogs_path
    elsif action_name == 'edit'
      blog_path
    end
  end
end
