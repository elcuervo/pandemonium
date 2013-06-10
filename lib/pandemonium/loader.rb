module Pandemonium
  module Loader
    REPO_FILE = File.expand_path("~/.pandemonium").freeze

    def initialize(config)
      @config = config
    end

    def load_repos
      puts "reloading repos"
      repos = TOML.load_file(REPO_FILE)
      @config["repos"] = repos
    end

    alias file_modified load_repos
  end

  class ConfigLoader
    include Loader
  end
end
