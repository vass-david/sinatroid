module Sinatroid

  class Application < Sinatra::Application
    set :slim, layout: :"layouts/app"

    not_found do
      slim :not_found
    end

    error do
      ExceptionMailer.send(request.env['sinatra.error']) \
        if settings.exception_mailer
      slim :error
    end

    get '/sitemap.xml' do
      slim :'sitemap', layout: false
    end

    get '*' do
      # set language
      @lang, path = parse_path
      I18n.locale = @lang

      # try to find & render template
      begin
        return slim path.join('/').to_sym
      rescue Errno::ENOENT
        raise Sinatra::NotFound
      end
    end
  end

end
