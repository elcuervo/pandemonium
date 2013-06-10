require "pandemonium/usain_bolt"

module Pandemonium
  Job = Struct.new(:command, :output, :exit_status) do
    def run
      puts "Unix, do your thing. Running #{command}"
      @shell_command = EM.popen(command, Pandemonium::UsainBolt, self)
    end

    def running?
      @shell_command.running?
    end
  end
end
