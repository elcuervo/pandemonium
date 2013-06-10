module Pandemonium
  Repo = Struct.new(:name, :repository, :deploy_script, :last_run, :last_status) do
    def save
      config = TOML.load_file(Pandemonium::Loader::REPO_FILE)
      config[name].merge!({
        "last_run"    => Time.now,
        "last_status" => last_status
      })

      toml_file = TOML.dump(config)

      File.write(Pandemonium::Loader::REPO_FILE, toml_file)
    end
  end
end
