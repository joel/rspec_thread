require File.expand_path('../lib/threadify', __FILE__)

class Main
  include Threadify

  attr_accessor :result, :verbose

  def initialize verbose = true
    @result = []
    @verbose = verbose
  end

  def work async = true
    sleeper = (1..3).to_a.reverse
    ['foo', 'bar', 'zone'].each_with_index do |variable, index|
      prepare(async) do
        sleep sleeper[index]
        puts "#{sleeper[index]} #{variable}" if verbose
        result << variable
      end
    end
  end

  def start async = true
    puts "#{async ? 'async' : 'inline' }" if verbose
    work async
    launch async
    puts result.join(', ') if verbose
  end

end

# Main.new(false).start(!ARGV.empty? && ARGV.first == 'async')

