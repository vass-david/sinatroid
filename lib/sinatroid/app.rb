# coding: utf-8

# base
require 'sinatra'
require 'sinatra/contrib'

# assets
require 'slim'
require 'sass'
require 'sinatra/asset_pipeline'
require 'compass'
require 'coffee-script'

# internationalization
require 'i18n'
require 'i18n/backend/fallbacks'

# custom utils
require_relative './lib/utils'

module Sinatroid
  class Application < Sinatra::Application

    set :root, Sinatroid::Environment.root

    register Sinatra::Contrib

    config_file File.join(settings.root, 'config', 'config.yml')

    # sprockets assets pipeline
    set :assets_path, -> { File.join(settings.root, 'assets') }
    set :assets_css_compressor, :sass
    set :assets_js_compressor, :uglifier

    register Sinatra::AssetPipeline

    # sinatra settings
    set :views, File.join(settings.root, 'views')

    configure do
      # logging
      enable :logging
      path = "#{settings.root}/log/"
      Dir.mkdir(path) unless File.directory?(path)
      file = File.new("#{path}/#{settings.environment}.log", 'a+')
      file.sync = true
      use Rack::CommonLogger, file


      # i18n
      locale = settings.default_locale if settings.methods.include? :default_locale
      I18n.default_locale = locale || 'en'
      I18n::Backend::Simple.send(:include, I18n::Backend::Fallbacks)
      I18n.load_path = Dir[File.join(settings.root, 'locales', '*.yml')]
      I18n.locale = 'en'
      I18n.backend.load_translations
    end

  end

end

# require helpers directory and include them in Sinatra App
require_tree File.join(Sinatroid::Application.settings.root, 'helpers/'), exclude: [__FILE__] do |path, name, ext|
  Sinatroid::Application.helpers Object.const_get(name.split('_').map!{|p| p.capitalize}.join()) \
end

# require routes directory
require_tree File.join(Sinatroid::Application.settings.root, 'routes/'), except: [__FILE__]
