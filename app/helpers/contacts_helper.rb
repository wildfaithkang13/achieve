module ContactsHelper
      #choose_new_or_editはメソッド名
  def choose_new_or_edit_for_contact
    if action_name == 'new' || action_name == 'confirm'
      confirm_contacts_path
    elsif action_name == 'edit'
      contact_path
    end
  end
end
