class NoticeMailer < ApplicationMailer
  def sendmail_blog(blog)
    @blog = blog

    mail to: 'j-quatum_khan07@docomo.ne.jp',
         subject: '【Achieve】ブログが投稿されました'
  end

  def sendmail_contact(contact)
  @contact = contact

      mail to: 'j-quatum_khan07@docomo.ne.jp',
       subject: '【Achieve】お問い合わせが完了しました'
  end
end
