require "pandemonium/repo"

module Pandemonium
  class Repos
    def initialize
      @repos = []
    end

    def [](name)
      @repos.select { |item| item.name == name }.first
    end

    def <<(repo)
      @repos << repo
    end

    def load(array)
      Array(array).each do |name, repo|
        @repos << Repo.new(name, repo["repository"], repo["deploy_script"])
      end
    end
  end
end
