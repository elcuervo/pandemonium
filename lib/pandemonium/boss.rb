require "pandemonium/job"

module Pandemonium
  Boss = Struct.new(:channel) do
    def run_command(repo, deploy_script)
      puts "Starting Job"
      worker = File.join(File.expand_path("../../..", __FILE__), "bin/worker.sh")

      @working_on = Pandemonium::Job.new("#{worker} #{repo} #{deploy_script}", channel)
      @working_on.run
    end

    def running?
      !!@working_on && @working_on.running?
    end
  end
end
