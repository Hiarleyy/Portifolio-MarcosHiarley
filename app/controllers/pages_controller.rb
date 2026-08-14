class PagesController < ApplicationController
  def home
    @featured_projects = Project.featured.limit(3)
    @recent_articles = Article.recent
  end

  def about
  end

  def contact
  end

  def send_contact
    name    = params[:name].to_s.strip
    email   = params[:email].to_s.strip
    subject = params[:subject].to_s.strip
    message = params[:message].to_s.strip

    if name.blank? || email.blank? || message.blank?
      redirect_to contact_path, alert: t("contact.form.errors.required_fields", default: "Por favor, preencha todos os campos obrigatórios.")
      return
    end

    ContactMailer.new_message(
      name:    name,
      email:   email,
      subject: subject,
      message: message
    ).deliver_now

    redirect_to contact_path, notice: t("contact.form.success", default: "Mensagem enviada com sucesso! Entrarei em contato em breve.")
  rescue => e
    Rails.logger.error "ContactMailer error: #{e.message}"
    redirect_to contact_path, alert: t("contact.form.errors.delivery_failed", default: "Erro ao enviar mensagem. Tente novamente ou use o WhatsApp.")
  end
end
