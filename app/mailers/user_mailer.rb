class UserMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer' # to make sure that your mailer uses the devise views

  def confirmation_instructions(record, token, opts={})
    opts[:from] = NOREPLY_EMAIL
    opts[:reply_to] = SUPPORT_EMAIL
    opts[:subject] = 'Confirmation Instructions | WachaSAY'
    super
  end

  def reset_password_instructions(record, token, opts={})
    opts[:from] = NOREPLY_EMAIL
    opts[:reply_to] = SUPPORT_EMAIL
    opts[:subject] = 'Reset Password Instructions | WachaSAY'
    super
  end

  def unlock_instructions(record, token, opts={})
    opts[:from] = NOREPLY_EMAIL
    opts[:reply_to] = SUPPORT_EMAIL
    opts[:subject] = 'Unlock Account Instructions | WachaSAY'
    super
  end

end
