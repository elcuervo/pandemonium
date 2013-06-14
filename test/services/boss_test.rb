require "test_helper"
require "pandemonium/services/boss"

describe Pandemonium::Services::Boss do
  let(:repo) { Pandemonium::Models::Repo.spawn }
  before     { Pandemonium::Services::Boss.call(repo) }

  it("should add a job to the repo") { assert repo.jobs.size == 1 }
end
