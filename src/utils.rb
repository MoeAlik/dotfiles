def get_toml_object
  toml_dumps = File.read("configs/config.toml")
  TomlRB.parse(toml_dumps)
end

def link(path)
  # is there a ruby path abstraction?
  project_path = "#{$files_path}/#{File.basename(path)}"
  if File.exist?(project_path)
    FileUtils.remove_file(project_path)
  end
  File.link(path, project_path)
end

def get_tracked_paths
  $config
    .select { |k, v| v["systems"].include?($system) }
    .map { |_, v| v["path"] }
end
