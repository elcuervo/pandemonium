require "spawn"
require "pandemonium/models/repo"
require "pandemonium/models/job"

def spawn(klass, &block)
  klass.extend(Spawn)
  klass.spawner(&block)
end

spawn(Pandemonium::Models::Repo) do |repo|
  repo.name       = "pandemonium"
  repo.repository = "git@github.com:elcuervo/pandemonium.git"
end

spawn(Pandemonium::Models::Job) do |job|
  job.repo ||= Pandemonium::Models::Repo.spawn
end
