require 'tty/table'

class TicketsView
  TICKETS_OVERVIEW_ATTRIBUTES = %w[id subject requester_id created_at priority]

  def fetch_ticket_info(ticket)
    ticket_info = Array.new

    TICKETS_OVERVIEW_ATTRIBUTES.each do |attr|
      ticket.key?(attr) ? ticket_info << ticket[attr] : ticket_info << nil
    end
    ticket_info
  end

  def display(tickets)
    tickets_table = TTY::Table.new(header: TICKETS_OVERVIEW_ATTRIBUTES)
    tickets.each do |ticket|
      tickets_table << fetch_ticket_info(ticket)
    end
    puts tickets_table.render(:ascii, padding: [0.5, 1])
  end
end
