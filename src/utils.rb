def get_toml_object
    toml_dumps = File.read("configs/config.toml")
    return TomlRB.parse(toml_dumps)
end

def link(path)
    # is there a ruby path abstraction?
    project_path = "#{$files_path}/#{File.basename(path)}"
    if File.exist?(project_path)
        FileUtils.remove_file(project_path)
    end
    File.link(path, project_path)
end