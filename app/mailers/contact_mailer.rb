class ContactMailer < ApplicationMailer
  default to: ENV["CONTACT_EMAIL"]

  def new_message(params)
    @name    = params[:name]
    @email   = params[:email]
    @subject = params[:subject].presence || "Novo contato pelo portfólio"
    @message = params[:message]

    mail(
      from:     "\"#{@name}\" <#{ENV["SMTP_USERNAME"]}>",
      reply_to: @email,
      subject:  "[Portfólio] #{@subject}"
    )
  end
end
