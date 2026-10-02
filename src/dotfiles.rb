require "etc"
require "pp"
require "fileutils"
require "optparse"
require "toml-rb"

require_relative "args"
require_relative "utils"

Dir.children("src/commands")
  .map { |command| "commands/#{command}" }
  .each { |command| require_relative command }

$files_path = "files"
$system
$config

$BANNER = <<~HEREDOC
  dotfiles manager
HEREDOC

def run
  $parser.parse!

  if $options.size > 1
    raise "Too many commands selected."
  end

  _, fn = $options.first
  fn
end

def main
  $system = Etc.uname[:sysname]
  $config = get_toml_object
  $parser.banner = $BANNER

  run
end

if __FILE__ == $0
  main
end
