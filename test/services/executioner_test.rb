require "test_helper"
require "pandemonium/services/executioner"

describe Pandemonium::Services::Executioner do
  let(:job)     { Pandemonium::Models::Job.spawn }
  let(:channel) { StringIO.new }
  let(:proxy)   { MiniTest::Mock.new }
  let(:runner)  { Pandemonium::UsainBolt }

  before do
    proxy.expect(:popen, true, [
      Pandemonium::Services::Executioner.build_command(job),
      runner,
      job,
      channel
    ])

    Pandemonium::Services::Executioner.call(job, channel, runner, proxy)
  end

  it("should be running")  { assert job.running? }
  it("should run the job") { assert !job.finished? }
  it("should execute the job") { assert proxy.verify }
end
