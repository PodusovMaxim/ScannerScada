require './model/node_info'
require './model/port_info'
require './model/os'
require './model/vulnerability_info'
require 'xmlsimple'

class Parser
  def self.nodeParser(path)
    arr_os = Array.new

    config = XmlSimple.xml_in(path)

    ip = ignore_exception {config['host'][0]['address'][0]['addr']}
    name =  ignore_exception {config['host'][0]['hostnames'][0]['hostname'][0]['name']}
    s = ignore_exception {config['host'][0]['os'][0]['osmatch'][0]['osclass']}

    if 'unknown'==s
      arr_os << Os.new('unknown', 'unknown', 'unknown', 0)
    else
      s.each {|x| arr_os << Os.new(x['vendor'], x['osfamily'], x['osgen'], x['accuracy'])}
    end

    arr_port_info = Parser.portParser(path)
    NodeInfo.new(ip,name,arr_os,arr_port_info)
  end

  def self.portParser(path)
    arr_port_info = Array.new
    config = XmlSimple.xml_in(path)
    ports = ignore_exception {config['host'][0]['ports'][0]['port']}
    if 'unknown'==ports
      arr_port_info<<PortInfo.new('unknown','unknown','unknown','unknown','unknown', 'unknown')
    else
      ports.each do |x|
        protocol = x['protocol']
        port = x['portid']
        status = x['state'][0]['state']
        service = x['service'][0]['name']
        product = x['service'][0]['product']
        product=(product.instance_of?NilClass)?'unknown':product
        version = x['service'][0]['version']
        version=(version.instance_of?NilClass)?'unknown':version
        arr_port_info<<PortInfo.new(port,protocol,status,service,product,version)
      end
    end
    arr_port_info
  end


  def self.vulnerabilityParser(path)
    vulnerabilities = []
    or_and_arr = []
    and_arr = []
    config = XmlSimple.xml_in(path)
    info = config['vulnerability'][0]['info'][0]

    conf = config['vulnerability'][0]['OR'][0]["AND"]
    conf.each do |_or|
      _or['operand'].each do |_and|
       and_arr<<_and
      end
      or_and_arr<<and_arr
      and_arr = []
    end

    name = info['name']
    cvss = info['CVSS']
    url = info['url']
    description = info['description']

    vulnerabilities<<VulnerabilityInfo.new(name, cvss, url, description, or_and_arr)
  end

end

def ignore_exception
  begin
    yield
  rescue Exception
    'unknown'
  end
end