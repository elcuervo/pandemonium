require "pandemonium/usain_bolt"

module Pandemonium
  Job = Struct.new(:repo, :output) do
    def run
      worker = File.join(File.expand_path("../../..", __FILE__), "bin/worker.sh")
      command = "#{worker} '#{repo.name}' '#{repo.repository}' '#{repo.deploy_script}'"
      puts "Unix, do your thing. Running #{command}"

      @shell_command = EM.popen(command, Pandemonium::UsainBolt, self)
    end

    def running?
      @shell_command.running?
    end

    def finish(exit_status)
      repo.last_status = exit_status
      repo.save
    end
  end
end
