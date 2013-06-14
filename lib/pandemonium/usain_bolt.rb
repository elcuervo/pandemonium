require "pandemonium/message"

module Pandemonium
  class UsainBolt < EM::Connection
    def initialize(job, channel)
      @job = job
      @output = channel
    end

    def post_init
      @running = true
      puts "Running!"
    end

    def receive_data(data)
      @output << Pandemonium::Message.new(:data, data)
      puts "Command output: #{data}"
    end

    def unbind
      @running = false
      @job.finish(get_status.exitstatus)

      @output << Pandemonium::Message.new(:exit_status, get_status.exitstatus)
      @output << Pandemonium::Message.new(:action, :finish)
    end

    def running?; @running; end
  end
end
