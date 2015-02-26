require 'optparse'

class Repete
  def self.hook
    $stdin = new($stdin)
  end

  def self.unhook
    $stdin.finish if $stdin.is_a?(Repete)
    $stdin = STDIN
  end

  def initialize(real_stdin)
    set_options

    @output_stream = @real = real_stdin
    @output_stream = File.open("tmp/stdin.log", "w") if !@playback_mode
    @output_stream
  end

  def gets(*args)
    if @playback_mode
      @input_stream = File.open("tmp/stdin.log", "r") if !@input_stream
      input = @input_stream.gets(*args)

      if !input
        puts "==Repete message== Done reading from file, switching to append mode"
        @playback_mode = false
        @output_stream = File.open("tmp/stdin.log", "a")
        input = @real.gets(*args)
      end
    else
      input = @real.gets(*args)
    end

    log(input)
    input
  end

  def log(input)
    if @playback_mode
      puts input
    else
      @output_stream.puts input
      @output_stream.flush
    end
  end

  def finish
    @input_stream.close if @input_stream
    @output_stream.close if !@playback_mode
  end

  private

  def set_options
    OptionParser.new do |opts|
      opts.banner = "Usage: example.rb [options]"

      opts.on("--repete[=OPTIONAL]", "--playback[=OPTIONAL]", "Playback previous input") do |rp|
        @playback_mode = true
      end
    end.parse!
  end
end
