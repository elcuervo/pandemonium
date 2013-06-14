require "test_helper"
require "pandemonium/models/job"

describe Pandemonium::Models::Job do
  subject { Pandemonium::Models::Job.spawn }

  it("should exist")                { assert !!subject }
  it("should have a start time")    { assert !!subject.start_time }
  it("should not have an end time") { assert !subject.end_time }
  it("should have a Repo")          { assert subject.repo }
end
