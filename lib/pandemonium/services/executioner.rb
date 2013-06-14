require "pandemonium/usain_bolt"

module Pandemonium
  module Services
    module Executioner
      WORKER = File.join(File.expand_path("../../..", __FILE__), "bin/worker.sh").freeze

      class << self
        def build_command(job)
          "#{WORKER} #{job.repo.name} #{job.repo.repository}"
        end

        def call(job, channel, runner = Pandemonium::UsainBolt, shell = EM)
          shell.popen(build_command(job), runner, job, channel)
        end
      end
    end
  end
end
