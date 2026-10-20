require_relative "../utils"

module Validate
  extend self

  def register
    $parser.on("-v", "--validate", "Validate tracked project files agree with system.") do |v|
      $options[:validate] = validate
    end
  end

  def validate
    $config.each do |setting, config_types|
      if !on_system?(config_types)
        next
      end

      file_settings = []

      if config_types.include?("files")
        file_settings.concat(config_types["files"])
      end

      if config_types.include?("commands")
        file_settings.concat(config_types["commands"])
      end

      file_settings.each do |v|
        project_path = get_project_path(v)

        if !File.exist?(project_path)
          p "#{setting} missing project_path."
        end

        if !v.include?("path")
          next
        end

        path = File.expand_path(v["path"])
        if !File.exist?(path)
          p "#{setting} missing path."
        end

        if !File.identical?(path, project_path)
          p "#{setting}: file and project file do not agree"
          next
        end

        p "#{setting}: verified"
      end
    end
  end
end

Validate.register
