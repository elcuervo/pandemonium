require "goliath"

module Pandemonium
  class API < Goliath::API
    use Goliath::Rack::Params
    use Goliath::Rack::Render, ["json"]

    def response(env)
      case env["PATH_INFO"]
      when "/"
        [200, {}, "Pandemonium"]
      when "/attach"
        project_name = env.params["project_name"]
        boss         = env.jobs[project_name]
        channel      = boss.channel

        env.stream_close if !boss || !boss.running?

        env["subscription"] = channel.subscribe do |message|
          case message.type
          when :data
            env.stream_send(message.content)
          when :exit_status
            env.stream_send("Exit status: #{message.content}")
          when :action
            if message.content == :finish
              channel.unsubscribe(env["subscription"])
              env.stream_close
            end
          end
        end

        streaming_response(202, {"X-Stream" => "Pandemonium"})
      when "/deploy"
        project_name = env.params["project_name"]
        boss = env.jobs[project_name]

        if boss.running?
          [200, {}, "Already deploying"]
        else
          boss.run_command("./test.sh")
          [201, {}, "Deploying"]
        end
      end
    end
  end
end
