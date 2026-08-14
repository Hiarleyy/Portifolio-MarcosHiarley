class ApplicationController < ActionController::Base
  before_action :set_locale

  private

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    if [:en, :pt, :"pt-BR"].include?(locale)
      locale = :pt if locale == :"pt-BR"
      cookies.permanent[:locale] = locale.to_s
      I18n.locale = locale
    elsif cookies[:locale].present? && [:en, :pt].include?(cookies[:locale].to_sym)
      I18n.locale = cookies[:locale].to_sym
    else
      I18n.locale = I18n.default_locale
    end
  end

  def default_url_options
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end
end
