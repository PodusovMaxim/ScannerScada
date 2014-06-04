class AddScan
  attr_accessor :ip
  attr_accessor :current_port_info

  def initialize(ip, current_port_info)
    @ip = ip
    @current_port_info = current_port_info
  end

end