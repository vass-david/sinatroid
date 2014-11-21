module I18nHelpers

  def t(string, params={})
    I18n.t string, params
  end

  def current_locale
    I18n.locale
  end

end
