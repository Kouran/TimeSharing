# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( style.css )
Rails.application.config.assets.precompile += %w( micro.css )
Rails.application.config.assets.precompile += %w( flexslider.css )
Rails.application.config.assets.precompile += %w( jquery-1.7.2.min.js )
Rails.application.config.assets.precompile += %w( modernizr.custom.js )
Rails.application.config.assets.precompile += %w( jquery.flexslider-min.js )
Rails.application.config.assets.precompile += %w( functions.js )
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
