module Parse
  extend self

  def register
    $parser.on("-p", "--parse", "Verify config syntax and semantics.") do |v|
      $options[:parse] = parse
    end
  end

  def parse
    p $config
  end
end

Parse.register
