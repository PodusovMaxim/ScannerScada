class DangerousNode
  attr_accessor :nodeInfo
  attr_accessor :vulnerabilityInfo
  attr_accessor :prob

  def initialize(nodeInfo, vulnerabilityInfo, prob)
    @nodeInfo = nodeInfo
    @vulnerabilityInfo = vulnerabilityInfo
    @prob = prob
  end

  def to_s
    "NODE=#{@nodeInfo} VULNERABILITY=#{@vulnerabilityInfo} PROB=#{@prob}"
  end
end