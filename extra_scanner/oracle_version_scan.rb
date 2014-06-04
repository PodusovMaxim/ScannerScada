require 'socket'

class OracleVersionScan < AddScan

  def run
    puts "ORACLE VERSION SCAN: IP=#{ip} PORT=#{current_port_info.port}"

    current_port_info.version = '1.0.1'
    current_port_info
  end

  def body
    pkt = tns_packet("(CONNECT_DATA=(COMMAND=VERSION))")

    port = current_port_info.port.to_s
    host = ip
    sock = TCPSocket.new(host, port)

    sock.puts(pkt)
    data = sock.gets

    if ( data and data =~ /\\*.TNSLSNR for (.*)/ )
      ora_version = data.match(/\\*.TNSLSNR for (.*) Version (.*) - Production/)[2]
      #  puts("#{host} Oracle version = " + ora_version)
      current_port_info.version = ora_version
      #else
      #  puts( "#{host} Oracle version = Unknown")
      current_port_info
    end
  end

  def tns_packet(connect_data)
    packet_length = [58 + connect_data.length].pack('n')
    # Packet length
    pkt =  packet_length
    # Checksum
    pkt << "\x00\x00"
    # Packet Type: Connect(1)
    pkt << "\x01"
    # Reserved
    pkt << "\x00"
    # Header Checksum
    pkt << "\x00\x00"
    # Version
    pkt << "\x01\x36"
    # Version (Compatible)
    pkt << "\x01\x2C"
    pkt << "\x00\x00\x08\x00"
    pkt << "\x7F\xFF"
    pkt << "\x7F\x08"
    pkt << "\x00\x00"
    pkt << "\x00\x01"
    pkt << [connect_data.length].pack('n')
    pkt << "\x00\x3A"
    pkt << "\x00\x00\x00\x00"
    pkt << "\x00\x00\x00\x00"
    pkt << "\x00"
    pkt << "\x00"
    pkt << "\x00\x00\x00\x00"
    # Unique Connection ID
    pkt << "\x00\x00\x34\xE6\x00\x00\x00\x01"
    # Connect Data
    pkt << "\x00\x00\x00\x00\x00\x00\x00\x00"
    pkt << connect_data
    return pkt
  end
end