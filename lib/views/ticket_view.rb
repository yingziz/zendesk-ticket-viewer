require 'tty/prompt'

class TicketView
  TICKET_ATTRIBUTES = %w[id type subject description created_at updated_at status]

  def initialize
    @pastel = Pastel.new
    @prompt = TTY::Prompt.new
  end

  def fetch_ticket_info(ticket)
    ticket_info = Array.new

    TICKET_ATTRIBUTES.each do |attr|
      ticket_attr = Array.new
      ticket_attr << attr
      ticket_attr << (ticket.key?(attr) && ticket[attr] ? ticket[attr] : 'N/A')
      ticket_info << ticket_attr
    end
    ticket_info
  end

  def display(ticket)
    if ticket == nil
      @prompt.warn("Sorry, ticket cannot be found. \n")
    else
      ticket_info = fetch_ticket_info(ticket)
      # Known issue in TTY https://github.com/piotrmurach/tty-table/issues/35
      # ticket_table = TTY::Table.new(ticket_info)
      # puts ticket_table.render(:ascii, mutiline: true)
      @prompt.say('Ticket Details')
      ticket_info.each do |row|
        @prompt.say("#{@pastel.magenta.bold(row[0])}: #{row[1]} \n")
      end
    end
  end
end
