class Analysis
  def self.startAnalysis(nodeInfo, vulnerabilities)
    portsInfo = nodeInfo[0].port_info
    vulnerabilities.each do |vul|
      vul.configuration.each do |_and|
        puts _and
      end
    end
  end
end