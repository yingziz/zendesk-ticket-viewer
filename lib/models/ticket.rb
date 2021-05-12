class Ticket
  attr_reader :id, :created_at, :type, :subject, :description, :priority, :status
  def initialize(params)
    params['tickets'].each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end
end
