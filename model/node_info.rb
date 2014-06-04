class NodeInfo
  attr_accessor :ip
  attr_accessor :name
  attr_accessor :os
  attr_accessor :port_info

  def initialize(ip, name, os, port_info)
    @ip = ip
    @name = name
    @os = os
    @port_info = port_info
  end

  def to_s
    "IP=#{@ip} NAME=#{@name} OS=#{@os} PORT_INFO=#{@port_info}"
  end
end