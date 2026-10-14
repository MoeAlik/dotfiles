module Parse
  extend self

  @@required_fields = [
    "project_path"
  ]

  def register
    $parser.on("-p", "--parse", "Verify config syntax and semantics.") do |v|
      $options[:parse] = parse
    end
  end

  def parse
    $config.each do |setting, config_types|
      file_settings = []

      if config_types.include?("files")
        file_settings.concat(config_types["files"])
      end

      if config_types.include?("commands")
        file_settings.concat(config_types["commands"])
      end

      file_settings.each do |file_setting|
        @@required_fields.each do |required_field|
          if !file_setting[required_field]
            raise "no #{required_field} specified in #{setting} setting"
          end
        end
      end
    end
  end
end

Parse.register
