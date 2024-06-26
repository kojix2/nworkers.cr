# https://github.com/crystal-lang/crystal/blob/master/src/crystal/scheduler.cr

{% if flag?(:preview_mt) %}
  class Crystal::Scheduler
    def self.add_worker
      pending = Atomic(Int32).new(1)
      th = Thread.new(name: "CRYSTAL-MT-#{number_of_workers}") do
        scheduler = Thread.current.scheduler
        pending.sub(1)
        scheduler.run_loop
      end
      @@workers.not_nil! << th
      while pending.get > 0
        Fiber.yield
      end
    end

    def self.remove_worker
      return if @@workers.not_nil!.size <= 1
      @@workers.not_nil!.pop
    end

    # Returns the number of workers

    def self.number_of_workers
      @@workers.not_nil!.size
    end
  end
{% end %}
