require "pandemonium/job"

module Pandemonium
  Boss = Struct.new(:channel) do
    def run_command(command)
      puts "Starting Job"

      @working_on = Pandemonium::Job.new(command, channel)
      @working_on.run
    end

    def running?
      !!@working_on && @working_on.running?
    end
  end
end
