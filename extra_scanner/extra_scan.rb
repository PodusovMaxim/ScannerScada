class ExtraScan
  def self.run(nodes)
    tests = []
    File.open('extra_scan.property', 'r')do |x|
      while (line = x.gets)
        tests<<Object.const_get(line.chomp)
      end
    end

    tests.each do |test|
      nodes.each do |node|
        script = test.checkEndCreate(node)
        unless script.nil?
          data = script.run
          test.apply(data, node)
        end
      end
    end

  end
end