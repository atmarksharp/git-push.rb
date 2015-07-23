require 'open3'
require 'optparse'

RED = "\e[31m"
GREEN = "\e[32m"
CLEAR = "\e[0m"

# ==============================

def sh(command,quiet=nil)
  stdout, stderr, process = Open3.capture3(command)
  if quiet != true
    puts stdout

    if stdout != nil
      puts stderr
    end
  end

  @sh_err = stderr
  return stdout
end

# ==============================

OPTS = {}
opt = OptionParser.new do |opt|
  opt.on('-m VAL'){|v| OPTS[:m] = v}
  opt.on_tail("-h", "--help", "") do |v|
    script_name = File.basename($0)
    opt.banner = "Usage: git-push [mode] -m [message]"
    puts opt.banner
    # puts opt
    exit
  end
  opt.parse!(ARGV)
end

target = ARGV[0]
message = OPTS[:m]

# if not initialized
nogit = (Dir.exists?(".git") == false)

if nogit
  puts "#{RED}[FATAL] Current dir is not initialized!#{CLEAR}"
  puts "#{RED} --> Please type `git init`#{CLEAR}"

  exit 1
end

if target == 'push'
  if message == nil
    puts "#{RED}[ERROR] commit message is empty#{CLEAR}"
  end
elsif target == 'commit'
  if message == nil
    puts "#{RED}[ERROR] commit message is empty#{CLEAR}"
  end
else
  puts "#{RED}[FATAL] Select valid mode#{CLEAR}"
end
