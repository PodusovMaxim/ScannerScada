require './extra_scanner/add_scan'

module AbstractFactoryScan
  def self.checkEndCreate(data)
    raise NotImplementedError, "You should implement this method"
  end
  def self.apply(data, node)
    raise NotImplementedError, "You should implement this method"
  end
end