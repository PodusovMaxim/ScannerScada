class Scan
  def self.startScan(mode, who, path)
    puts "MODE=#{mode} ~ PATH=#{path} ~ WHO=#{who}"
    case mode
      when :speed
        Kernel.open("|nmap -sS -sU -O -T5 --fuzzy --allports --version-all #{who} -oX #{path}"){|x| x.gets}
      when :normal
        Kernel.open("|nmap -sS -sU -O -T3 --fuzzy --allports --version-all #{who} -oX #{path}"){|x| x.gets}
      when :slow
        Kernel.open("|nmap -sS -sU -O -T1 --fuzzy --allports --version-all #{who} -oX #{path}"){|x| x.gets}
      else
        raise "Incorrect mode: #{mode}\nUse only \"speed\" or \"normal\" or \"slow\""
    end
  end
end

# -T1 оч долго
# -T5 Быстро

=begin
 case mode
      when :easy
        Kernel.open("|nmap -A #{who} -oX #{path}"){|x| x.gets}
      when :normal
        Kernel.open("|nmap -sS -sU -O -T1 #{who} -oX #{path}"){|x| x.gets}
      when :hard
        Kernel.open("|nmap -sS -sU -O -T5 #{who} -oX #{path}"){|x| x.gets}
      when :normal1
        Kernel.open("|nmap -sS -O -T5 #{who} -oX #{path}"){|x| x.gets}
      when :normal2
        Kernel.open("|nmap -sS -sU -O -T3--version-intensity=3 #{who} -oX #{path}"){|x| x.gets}
      when :hard2
        Kernel.open("|nmap -sS -sU -O -T3--fuzzy --allports --version-all #{who} -oX #{path}"){|x| x.gets}
      else
        puts "Incorrect mode=#{mode}"
    end
=end