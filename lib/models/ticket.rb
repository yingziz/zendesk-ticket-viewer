class Ticket
  attr_reader :id, :created_at, :updated_at, :type, :subject, :description, :priority, :status
  def initialize(params)
    params.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end
end
