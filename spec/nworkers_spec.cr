require "./spec_helper"

class Crystal::Scheduler
  def self.check_worker_names
    names = @@workers.not_nil!.map { |w| w.name }
    return false unless names.shift.nil?
    c = 0
    names.all? do |name|
      c += 1
      name == "CRYSTAL-MT-#{c}"
    end
  end
end

describe NWorkers do
  it "has a version number" do
    (NWorkers::VERSION).should be_a(String)
  end

  {% if flag?(:preview_mt) %}
    it "sets the number of workers" do
      NWorkers.set_worker(1).should eq(1)
      NWorkers.size.should eq(1)
      Crystal::Scheduler.check_worker_names.should be_truthy
      NWorkers.set_worker(2).should eq(2)
      NWorkers.size.should eq(2)
      Crystal::Scheduler.check_worker_names.should be_truthy
      NWorkers.set_worker(3).should eq(3)
      NWorkers.size.should eq(3)
      Crystal::Scheduler.check_worker_names.should be_truthy
      NWorkers.set_worker(4).should eq(4)
      NWorkers.size.should eq(4)
      Crystal::Scheduler.check_worker_names.should be_truthy
      NWorkers.set_worker(5).should eq(5)
      NWorkers.size.should eq(5)
      Crystal::Scheduler.check_worker_names.should be_truthy
      NWorkers.set_worker(6).should eq(6)
      NWorkers.size.should eq(6)
      Crystal::Scheduler.check_worker_names.should be_truthy
      expect_raises(ArgumentError) { NWorkers.set_worker(0) }
      expect_raises(ArgumentError) { NWorkers.set_worker(-1) }
      Crystal::Scheduler.check_worker_names.should be_truthy
    end

    it "adds workers" do
      NWorkers.set_worker(4).should eq(4)
      Crystal::Scheduler.check_worker_names.should be_truthy
      NWorkers.add_worker(1).should eq(1)
      NWorkers.size.should eq(5)
      Crystal::Scheduler.check_worker_names.should be_truthy
      NWorkers.add_worker(2).should eq(2)
      NWorkers.size.should eq(7)
      Crystal::Scheduler.check_worker_names.should be_truthy
    end

    it "removes workers" do
      NWorkers.set_worker(4).should eq(4)
      Crystal::Scheduler.check_worker_names.should be_truthy
      NWorkers.remove_worker(1).should eq(1)
      NWorkers.size.should eq(3)
      Crystal::Scheduler.check_worker_names.should be_truthy
      NWorkers.remove_worker(2).should eq(2)
      NWorkers.size.should eq(1)
      Crystal::Scheduler.check_worker_names.should be_truthy
    end
  {% else %}
    # If multi-threading is not enabled, all methods should return nil or 1

    it "dose not set the number of workers" do
      NWorkers.set_worker(-1).should be_nil
      NWorkers.set_worker(0).should be_nil
    end

    it "does not add workers" do
      NWorkers.add_worker(-1).should be_nil
      NWorkers.add_worker(0).should be_nil
      NWorkers.add_worker(1).should be_nil
      NWorkers.add_worker(2).should be_nil
    end

    it "does not remove workers" do
      NWorkers.remove_worker(-1).should be_nil
      NWorkers.remove_worker(0).should be_nil
      NWorkers.remove_worker(1).should be_nil
      NWorkers.remove_worker(2).should be_nil
    end

    it "counts workers (size)" do
      NWorkers.size.should eq(1)
    end

    it "counts workers (count)" do
      NWorkers.count.should eq(1)
    end
  {% end %}
end
