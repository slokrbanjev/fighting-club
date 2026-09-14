# Lokales Mini-Gem: stellt den Befehl `middleman deploy` bereit (build/ -> gh-pages).
# Ersetzt das verwaiste Gem middleman-deploy 2.0.0.pre.alpha (2015), das mit Ruby >= 3.1 nicht mehr lädt (net/ftp).
Gem::Specification.new do |s|
  s.name        = 'middleman-deploy-ghpages'
  s.version     = '1.0.0'
  s.summary     = 'middleman deploy: Seite bauen und build/ auf den gh-pages-Branch pushen'
  s.authors     = ['Fighting Club Meran/o']
  s.files       = Dir['lib/**/*.rb']
  s.require_paths = ['lib']
  s.required_ruby_version = '>= 3.1'
  s.add_dependency 'middleman-cli', '~> 4.0'
  s.add_dependency 'middleman-core', '~> 4.0'
end
