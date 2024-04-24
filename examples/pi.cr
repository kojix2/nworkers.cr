require "../src/nworkers"
require "option_parser"

num_workers = NWorkers.size || 1
total_points = 10000000

OptionParser.parse do |parser|
  parser.banner = "Usage: pi [options]"
  parser.on("-n", "--workers WORKERS", "Number of workers [#{num_workers}]") do |i|
    num_workers = i.to_i
    NWorkers.set_worker(num_workers)
  end
  parser.on("-p", "--points POINTS", "Number of points [#{total_points}]") do |i|
    total_points = i.to_i
  end
  parser.on("-h", "--help", "Show this help") do
    puts parser
    exit
  end
  parser.invalid_option do |flag|
    STDERR.puts "ERROR: #{flag} is not a valid option."
    STDERR.puts parser
    exit(1)
  end
end

points_per_worker = (total_points / num_workers).to_i
channel = Channel(Float64).new(num_workers)

num_workers.times do |seed|
  spawn do
    random = Random.new(seed)
    count = 0
    points_per_worker.times do |i|
      x = random.rand
      y = random.rand
      count += 1 if x*x + y*y < 1
    end
    channel.send count
  end
end

results = Array.new(num_workers) { channel.receive }
pi = results.sum.to_f / total_points * 4

puts "num_workers=#{num_workers}, total_points=#{total_points}, pi=#{pi}"
