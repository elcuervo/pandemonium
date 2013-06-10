require "pandemonium/job"

module Pandemonium
  Boss = Struct.new(:channel) do
    def run_command(repo)
      puts "Starting Job"

      @working_on = Pandemonium::Job.new(repo, channel)
      @working_on.run
    end

    def running?
      !!@working_on && @working_on.running?
    end
  end
end
