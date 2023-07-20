class ServiceResponse
  attr_reader :data, :status, :meta

  def initialize(data: {}, status: :ok, meta: {})
    @data = data
    @meta = meta
    @status = status
  end

  def valid?
    status == :ok
  end
end
