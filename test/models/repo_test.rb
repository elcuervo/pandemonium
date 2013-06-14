require "test_helper"
require "pandemonium/models/repo"

describe Pandemonium::Models::Repo do
  subject { Pandemonium::Models::Repo.spawn }

  it("should exist")             { assert !!subject }
  it("should have a name")       { assert !!subject.name }
  it("should have a repository") { assert !!subject.repository }
  it("should have jobs set")     { assert_kind_of Ohm::List , subject.jobs }
end
