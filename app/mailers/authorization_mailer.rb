class AuthorizationMailer < ApplicationMailer

  def omniauth_registration(record, token, opts={})
    opts[:from] = NOREPLY_EMAIL
    opts[:reply_to] = SUPPORT_EMAIL
    opts[:subject] = 'Welcome to WachaSAY'
    @user = record
    @token = token
    mail(to: record.email,
        subject: opts[:subject],
        reply_to: opts[:reply_to],
        from: opts[:from])
  end
end
