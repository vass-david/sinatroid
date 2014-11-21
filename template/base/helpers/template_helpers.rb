module TemplateHelpers

  def partial(path, locals={}, &body)
    locals[:body] = body
    slim path.to_sym, layout: false, locals: locals
  end

  def mdown(string, &body)
    renderer = Redcarpet::Render::HTML.new(filter_html: false)
    engine = Redcarpet::Markdown.new(renderer)
    engine.render(string.empty? ? body.call : string)
  end

  def absolute_url(slug)
    "http://#{request.env['HTTP_HOST']}#{slug}"
  end

  SKIPPED_CHARS = ['<', '>', '-', '!', ',', '.']
  REPLACED_CHARS = {
    '-' => '&#8209;'
  }

  def save_short_words(max_chars=2, &body)
    result_string = []

    body = capture(&body)

    body.each_line do |line|
      l = line.split(" ")
      result_line = []
      omit = 0
      l.each_with_index do |word, index|
        if word and omit == 0
          i = 0

          while l[index+i+1] &&
            l[index+i] &&
            l[index+i].length <= max_chars &&
            !SKIPPED_CHARS.include?(l[index+i][-1])

            word += "&nbsp;" + l[index+i+1]
            i    += 1
            omit += 1
          end
          REPLACED_CHARS.each {|a, b| word.gsub!(a, b)}
          result_line << word
        else
          omit -= 1
        end
      end

      result_string << result_line.join(" ")
    end
    result_string.join("\n")
  end

end
