require_relative "../utils"

module Validate
  extend self

  def register
    $parser.on("-v", "--validate", "Validate tracked project files agree with system.") do |v|
      $options[:validate] = validate
    end
  end

  def validate
    $config.each do |setting, v|
      if !on_system?(v)
        next
      end

      path = File.expand_path(v["path"])
      project_path = get_project_path(v)

      path_result = File.exist?(path) ? "Found" : "Missing"
      project_path_result = File.exist?(project_path) ? "Found" : "Missing"

      if [path_result, project_path_result].include?("Missing")
        p "#{setting}: path: #{path_result}, project_path: #{project_path_result}"
        next
      end

      if !File.identical?(path, project_path)
        p "#{setting}: file and project file do not agree"
        next
      end

      p "#{setting}: verified"
    end
  end
end

Validate.register
