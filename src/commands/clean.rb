require_relative "../args"

module Clean
  extend self

  @@ignore_list = [".gitkeep"]

  def register
    $parser.on("-c", "--clean", "Delete untracked files.") do |v|
      $options[:clean] = clean
    end
  end

  def clean
    tracked_files = $config
      .map { |k, v| File.basename(v["path"]) }
    untracked_files = Dir.children($files_path)
      .reject { |f| @@ignore_list.include?(f) }
      .reject { |f| tracked_files.include?(f) }

    untracked_files.each do |f|
      p "removing untracked file #{f}"
      FileUtils.remove_file("#{$files_path}/#{f}")
    end
  end
end

Clean.register
