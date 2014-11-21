module RoutesHelpers
  def index_path
    lang_path
  end

  def lang_path
    parts = params[:splat][0].split('/')[1..-1]
    I18n.available_languages.include?(parts[0]) ? '/' + parts[0] : '/'
  end

  def parse_path
    parts = params[:splat][0].split('/')[1..-1]

    if parts
      if ['sk', 'en'].include? parts[0]
        lang = parts[0].to_sym
        path = parts[1..-1]
      else
        lang = detect_language
        path = parts
      end

      path = ['index'] if path == []

      [lang, path]
    else
      [detect_language, ['index']]
    end
  end

  def detect_language
    user_lang = request.env['HTTP_ACCEPT_LANGUAGE']
    I18n.available_locales.each { |lang|
      return lang if user_lang.include?(lang.to_s) }
  end

end
