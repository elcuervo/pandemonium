require "pandemonium/models/job"

module Pandemonium
  module Services
    module Boss
      def self.call(repo)
        job = Pandemonium::Models::Job.create(repo: repo)
        repo.jobs << job
      end
    end
  end
end
