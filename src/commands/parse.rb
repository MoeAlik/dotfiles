module Parse
  extend self

  @@required_fields = [
    "project_file",
    "systems"
  ]

  def register
    $parser.on("-p", "--parse", "Verify config syntax and semantics.") do |v|
      $options[:parse] = parse
    end
  end

  def parse
    $config.each do |setting, fields|
      @@required_fields.each do |required_field|
        if !fields[required_field]
          raise "no #{required_field} specified in #{setting} setting"
        end
      end
    end
  end
end

Parse.register
