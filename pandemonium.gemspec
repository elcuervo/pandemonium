Gem::Specification.new do |s|
  s.name         = "pandemonium"
  s.version      = "0.0.1"
  s.summary      = "Pandemonium the deployer"
  s.description  = "Pandemonium is an app to run deployment instructions"
  s.authors      = ["elcuervo"]
  s.email        = ["yo@brunoaguirre.com"]
  s.homepage     = "http://github.com/elcuervo/pandemonium"
  s.files        = `git ls-files`.split("\n")
  s.test_files   = `git ls-files test`.split("\n")

  s.add_dependency("goliath", "~> 1.0.2")
  s.add_dependency("clap", "~> 1.0.0")
  s.add_dependency("toml-rb", "~> 0.1.3")

#  s.add_development_dependency("minitest",  "~> 4.4.0")
end
