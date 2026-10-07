def get_toml_object
  toml_dumps = File.read("configs/config.toml")
  TomlRB.parse(toml_dumps)
end

def link_from_path(setting_dictionary)
  # is there a ruby path abstraction?
  project_path = "#{$files_path}/#{setting_dictionary["project_file"]}"
  path = File.expand_path(setting_dictionary["path"])
  if File.exist?(project_path)
    FileUtils.remove_file(project_path)
  end

  File.link(path, project_path)
end

def link_from_project(setting_dictionary)
  project_path = "#{$files_path}/#{setting_dictionary["project_file"]}"
  path = File.expand_path(setting_dictionary["path"])
  if File.exist?(path)
    FileUtils.remove_file(path)
  end

  File.link(project_path, path)
end

def get_tracked_paths
  $config
    .select { |k, v| v["systems"].include?($system) }
    .map { |_, v| v["path"] }
end

def get_tracked_paths_internal
  $config
    .select { |k, v| v["systems"].include?($system) }
    .map { |_, v| "#{$files_path}/#{File.basename(v["path"])}" }
end

def get_project_path(setting_dictionary)
  "#{$files_path}/#{setting_dictionary["project_file"]}"
end

def on_system?(setting_dictionary)
  setting_dictionary["systems"].include?($system)
end
