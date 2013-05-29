module Virgil
  Message = Struct.new(:type, :content)

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
      @output << Message.new(:data, data)
      @buffer << data

      puts "Command output: #{data}"
    end

    def unbind
      @running = false
      @job.exit_status = get_status.exitstatus
      @output << Message.new(:exit_status, @job.exit_status)
      @output << Message.new(:action, :finish)
    end

    def running?; @running; end
  end

  Boss = Struct.new(:channel) do
    def run_command(command)
      puts "Starting Job"

      @working_on = Job.new(command, channel)
      @working_on.run
    end

    def running?
      !!@working_on && @working_on.running?
    end
  end

  Job = Struct.new(:command, :output, :exit_status) do
    def run
      puts "Unix, do your thing. Running #{command}"
      @shell_command = EM.popen(command, UsainBolt, self)
    end

    def running?
      @shell_command.running?
    end

  end
end

config["jobs"] = Hash.new do |h, k|
  h[k] = Virgil::Boss.new(EM::Channel.new)
end
