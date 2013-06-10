require "pandemonium/message"

module Pandemonium
  class UsainBolt < EM::Connection
    def initialize(job)
      @job = job
      @output = job.output
      @buffer = StringIO.new
    end

    def post_init
      @running = true
      puts "Running!"
    end

    def receive_data(data)
      @output << Pandemonium::Message.new(:data, data)
      @buffer << data

      puts "Command output: #{data}"
    end

    def unbind
      @running = false
      @buffer = nil

      @job.exit_status = get_status.exitstatus
      @output << Pandemonium::Message.new(:exit_status, @job.exit_status)
      @output << Pandemonium::Message.new(:action, :finish)
    end

    def running?; @running; end
  end
end
