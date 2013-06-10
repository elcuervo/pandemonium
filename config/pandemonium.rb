require "toml"
require "pandemonium/boss"
require "pandemonium/loader"

EM.kqueue = true
EventMachine.watch_file(Pandemonium::Loader::REPO_FILE, Pandemonium::Loader, config)
Pandemonium::ConfigLoader.new(config).load_repos

config["jobs"] = Hash.new do |h, k|
  h[k] = Pandemonium::Boss.new(EM::Channel.new)
end
