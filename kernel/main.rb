require './network_scanner/scan'
require './parser/parser'
require 'require_all'
require './extra_scanner/extra_scan'
require './primary_analysis/analysis'
require_all './extra_scanner/'

class Main

  def self.new_task(mode, ip)
    path = "./result/#{Time.now.strftime('%s')}.xml"
    Scan.startScan(mode, ip, path)
    raise 'Nmap error' unless File.file?(path)
    Parser.nodeParser(path)
  end

  def self.continue_task(file)
    raise "File not exist: #{file}" unless File.file?(file)
    Parser.nodeParser(file)
  end

  def self.main
    type = ARGV[0].to_s.to_sym
    case type
      when :new
        ip = ARGV[1]
        mode = ARGV[2].to_s.to_sym
        Main.new_task(mode, ip)
      when :continue
        file = "./result/#{ARGV[1]}"
        Main.continue_task(file)
      else
        puts "Incorrect type: #{type}"
    end
  end

  nodes = []
  vulnerbilits = []
  begin
    nodes<<Main.main
  rescue => ex
    puts "#{ex.message}"
    exit -1
  end

  #ExtraScan.run(nodes)
  vulnerbilits = Parser.vulnerabilityParser('./result/vul.xml')
  Analysis.startAnalysis(nodes, vulnerbilits)
=begin
  arr=[]
  arr<<OracleVersionScanFactory
  arr<<PostgresVersionScanFactory

  arr.each do |x|
    x.create('192.168.1.1', '1521').run
  end

  clazz= Object.const_get('OracleVersionScanFactory')
  clazz.create('1.1.1.1','9999').run
=end
end
