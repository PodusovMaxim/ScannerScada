class PortInfo
  attr_accessor :port
  attr_accessor :protocol
  attr_accessor :status
  attr_accessor :service
  attr_accessor :product
  attr_accessor :version

  def initialize(port, protocol, status, service, product, version)
    @port = port
    @protocol = protocol
    @status = status
    @service = service
    @product = product
    @version = version
  end

  def ==(o)
    if o.is_a? PortInfo
      @port == o.port &&
          @protocol == o.protocol &&
          @status == o.status &&
          @service == o.service &&
          @product == o.product &&
          @version == o.version
    else
      false
    end
  end

  def to_s
    "PORT=#{@port} PROTOCOL=#{@protocol} STATUS=#{@status} SERVICE=#{@service} PRODUCT=#{@product} VERSION=#{@version}"
  end
end