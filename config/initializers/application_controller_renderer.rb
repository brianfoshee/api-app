ApplicationController.renderer.defaults.merge!(
  # http_host: 'example.com',
  https: Rails.env.production?
)
