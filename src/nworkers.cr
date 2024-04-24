require "./nworkers/version"
require "./ext/crystal_scheduler"

module NWorkers
  # Set the number of workers
  # @param n [Integer] number of workers

  def self.set_worker(n : Int)
    {% if flag?(:preview_mt) %}
      num_workers = count
      case n
      when 1...num_workers
        remove_worker(num_workers - n)
      when num_workers
        ENV["CRYSTAL_WORKERS"] = n.to_s # do nothing
      when (num_workers + 1)..
        add_worker(n - num_workers)
      else
        raise ArgumentError.new("Invalid number of workers: #{n}")
      end
      n
    {% end %}
  end

  # Add workers
  # @param n [Integer] number of workers to add
  # @return [Integer] n (nil if multi-threading is not enabled)

  def self.add_worker(n = 1)
    {% if flag?(:preview_mt) %}
      n.times { Crystal::Scheduler.add_worker }
      ENV["CRYSTAL_WORKERS"] = count.to_s
      n
    {% end %}
  end

  # Remove workers
  # @param n [Integer] number of workers to remove
  # @return [Integer] n (nil if multi-threading is not enabled)

  def self.remove_worker(n = 1)
    {% if flag?(:preview_mt) %}
      n.times { Crystal::Scheduler.remove_worker }
      ENV["CRYSTAL_WORKERS"] = count.to_s
      n
    {% end %}
  end

  # Number of workers

  def self.size
    {% if flag?(:preview_mt) %}
      Crystal::Scheduler.number_of_workers
    {% else %}
      1
    {% end %}
  end

  # alias for size

  def self.count
    size
  end
end
