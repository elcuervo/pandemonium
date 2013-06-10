require "pandemonium/boss"

config["jobs"] = Hash.new do |h, k|
  h[k] = Pandemonium::Boss.new(EM::Channel.new)
end
