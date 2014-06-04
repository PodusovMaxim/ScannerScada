require './extra_scanner/abstract_factory_scan'

class OracleVersionScanFactory
  @service = 'oracle-tns'
  @version = 'unknown'

  include AbstractFactoryScan
  def self.checkEndCreate(data)
    @current_port_info = data.port_info.find { |port| port.service == @service && port.version == @version }
    OracleVersionScan.new(data.ip, @current_port_info) if !@current_port_info.nil?
  end

  include AbstractFactoryScan
  def self.apply(data, node)
    node.port_info.delete(@current_port_info)
    node.port_info<<data
  end

end