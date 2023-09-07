require 'zen-grids'

activate :i18n, :mount_at_root => :de
activate :livereload

activate :sprockets do |sprockets|
  sprockets.supported_output_extensions = ['.js']
end

helpers do
  def nav_link(link_text, url, options = {})
    options[:class] ||= ""
    options[:class] << " active" if url == current_page.url
    link_to(link_text, url, options)
  end
end

set :css_dir, 'assets/css'
set :js_dir, 'assets/js'
set :images_dir, 'assets/img'

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :gzip
  activate :asset_hash
end

activate :deploy do |deploy|
  deploy.deploy_method = :git
  deploy.build_before = true
end
