require "goliath/runner"
require "toml"
require "uri"
require "pandemonium/api"
require "pandemonium/loader"

module Pandemonium
  module CLI
    class << self
      def run
        # There must be a prettier way to pass options to the runner
        argv = ["-sv"]
        argv << "-c"
        argv << File.join(File.expand_path("../../..", __FILE__), "config/pandemonium.rb")

        runner = Goliath::Runner.new(argv, nil)
        api    = Pandemonium::API

        runner.api = api.new
        runner.app = Goliath::Rack::Builder.build(api, runner.api)
        runner.run
      end

      def help
      end

      def list
        get_projects.each do |name, items|
          puts "#{name}: #{items["deploy_script"]}"
        end
      end

      def add(repo, script)
        config = get_projects
        project_name = File.basename(repo, ".git")

        config[escape_key(project_name)] = {
          repo: repo,
          deploy_script: script
        }

        File.open(Pandemonium::Loader::REPO_FILE, "w") << TOML.dump(config)
      end

      def get_projects
        TOML.load_file(Pandemonium::Loader::REPO_FILE)
      end

      def escape_key(key)
        key.tr("-", "_")
      end
    end
  end
end
