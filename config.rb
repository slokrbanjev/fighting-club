require 'zen-grids'

activate :i18n, :mount_at_root => :de
activate :livereload

helpers do
  # mailto-Link mit korrekt kodiertem Betreff (Leerzeichen/Umlaute -> %20 usw.)
  def mailto_link(address, subject)
    "mailto:#{address}?subject=#{ERB::Util.url_encode(subject)}"
  end

  def nav_link(link_text, url, options = {})
    options[:class] ||= ""
    options[:class] << " active" if url == current_page.url
    link_to(link_text, url, options)
  end
end

set :css_dir, 'assets/css'
set :js_dir, 'assets/js'
set :images_dir, 'assets/img'
set :fonts_dir, 'assets/fonts'

configure :build do
  activate :minify_css
  # Fertig minifizierte Fremdbibliotheken (assets/js/vendor) nicht nochmal durch Uglifier jagen
  activate :minify_javascript, ignore: [%r{/vendor/}]
  activate :gzip
  activate :asset_hash
end

# `middleman deploy` (build/ -> gh-pages) kommt aus lib/middleman-deploy-ghpages.
