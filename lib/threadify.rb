module Threadify

  attr_accessor :jobs

  def jobs
    @jobs ||= []
  end

  def prepare async = true
    if async
      thread = asyncronous { yield }
      jobs << thread
    else
      proc = inline { yield }
      jobs << proc
    end
  end

  def launch async = true
    async ? jobs.each(&:join) : jobs.each(&:call)
  end

  private

  def asyncronous
    Thread.new { yield }
  end

  def inline
    Proc.new { yield }
  end

end
