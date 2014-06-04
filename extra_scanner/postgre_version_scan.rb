class PostgresVersionScan < AddScan
  def run
    puts "POSTGRES VERSION SCAN: IP=#{ip} PORT=#{current_port_info.port}"
  end
end