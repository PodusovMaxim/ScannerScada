class Os
  attr_accessor :vendor
  attr_accessor :osfamily
  attr_accessor :osgen
  attr_accessor :prob

  def initialize(vendor, osfamily, osgen, prob)
    @vendor = vendor
    @osfamily = osfamily
    @osgen = osgen
    @prob = prob
  end

  def to_s
    "NAME=#{@vendor} #{@osfamily} #{@osgen} PROB=#{@prob}"
  end
end