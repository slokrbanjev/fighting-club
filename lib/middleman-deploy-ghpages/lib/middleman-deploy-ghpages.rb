require 'middleman-core'
require 'middleman-core/cli'

module Middleman
  module Cli
    # `bundle exec middleman deploy`
    #
    # 1. `middleman build -e production`
    # 2. im Ordner build/ (eigenes Git-Repo, Branch gh-pages): alles committen
    # 3. `git push -f origin gh-pages`  -> GitHub Pages veröffentlicht die Seite (fightingclub.it)
    #
    # Danach im Hauptrepo wie gewohnt: git add ... && git commit && git push
    class Deploy < Thor::Group
      include Thor::Actions

      check_unknown_options!
      namespace :deploy

      class_option :environment, aliases: '-e', type: :string, default: 'production',
                                 desc: 'Middleman-Umgebung für den Build'
      class_option :build_before, aliases: '-b', type: :boolean, default: true,
                                  desc: '`middleman build` vor dem Deploy ausführen'
      class_option :build_dir, type: :string, default: 'build', desc: 'Build-Ordner (eigenes Git-Repo)'
      class_option :remote, type: :string, default: 'origin', desc: 'Git-Remote im Build-Ordner'
      class_option :branch, type: :string, default: 'gh-pages', desc: 'Branch, auf den gepusht wird'

      def self.exit_on_failure?
        true
      end

      def deploy
        build_dir = File.expand_path(options[:build_dir])

        if options[:build_before]
          say "## middleman build -e #{options[:environment]}", :green
          sh("middleman build -e #{options[:environment]}")
        end

        unless File.directory?(File.join(build_dir, '.git'))
          raise Thor::Error, "#{build_dir} ist kein Git-Repo (Branch #{options[:branch]} erwartet)."
        end

        say "## Deploy #{build_dir} -> #{options[:remote]}/#{options[:branch]}", :green
        Dir.chdir(build_dir) do
          current = `git rev-parse --abbrev-ref HEAD`.strip
          unless current == options[:branch]
            raise Thor::Error, "Build-Ordner steht auf Branch '#{current}', erwartet '#{options[:branch]}'."
          end

          sh('git add -A')
          message = "Deploy #{Time.now.utc.strftime('%Y-%m-%d %H:%M:%S UTC')} (middleman deploy)"
          sh(%(git commit --allow-empty -m "#{message}"))
          sh("git push -f #{options[:remote]} #{options[:branch]}")
        end
        say '## Deploy fertig.', :green
      end

      private

      def sh(command)
        say "   #{command}", :cyan
        system(command) || raise(Thor::Error, "Fehler bei: #{command}")
      end
    end

    Base.register(Deploy, 'deploy', 'deploy [options]',
                  'Seite bauen und build/ auf GitHub Pages (Branch gh-pages) pushen')
    Base.map('d' => 'deploy')
  end
end
