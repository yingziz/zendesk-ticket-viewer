require_relative '../gateways/ticket_gateway'
require_relative '../views/tickets_view'
require_relative '../views/ticket_view'
require_relative '../models/ticket'

class TicketController
  def initialize(email, token)
    @tickets_view = TicketsView.new
    @ticket_view = TicketView.new
    @ticket_gateway = TicketGateway.new(email, token)
    @prompt = TTY::Prompt.new
  end

  def tickets(page_number)
    response = @ticket_gateway.fetch("https://lacyzhang.zendesk.com/api/v2/tickets.json?page=#{page_number}&per_page=25")
    @tickets_view.display(response['tickets'])
    response['next_page']
  end

  def ticket(ticket_number)
    response = @ticket_gateway.fetch("https://lacyzhang.zendesk.com/api/v2/tickets/#{ticket_number}.json")
    ticket = response['ticket'] ? Ticket.new(response['ticket']) : nil
    @ticket_view.display(ticket)
  end
end
