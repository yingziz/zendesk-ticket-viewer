class Router
  TICKETS_MENU = [
    '1. View previous page',
    '2. View next page',
    '3. Return to Menu'
  ]
  FIRST_PAGE_TICKETS_MENU = [
    { name: "1. View previous page", disabled: "(This is the first page.)" },
    '2. View next page',
    '3. Return to Menu'
  ]
  LAST_PAGE_TICKETS_MENU = [
    '1. View previous page',
    { name: "2. View next page", disabled: "(This is the last page.)" },
    '3. Return to Menu'
  ]
  MENU_OPTIONS = [
    '1. View all tickets',
    '2. View a ticket',
    '3. Quit'
  ]

  def initialize(controller)
    @controller = controller
    @running = true
    @prompt = TTY::Prompt.new
    @page_number = 1
    @is_under_tickets_menu = false
  end

  def run
    menu_choice = @prompt.select('Choose your options?', MENU_OPTIONS)
    case menu_choice
    when MENU_OPTIONS[0]
      tickets_page_select
    when MENU_OPTIONS[1]
      ticket_number = @prompt.ask('Enter ticket number:')
      @controller.ticket(ticket_number)
    when MENU_OPTIONS[2]
      @prompt.ok('Thank you for using Zendesk Ticket Viewer. Goodbye.')
      exit
    end
  end

  def tickets_page_select
    @is_under_tickets_menu = true
    while @is_under_tickets_menu
      has_next_page = @controller.tickets(@page_number) != nil

      if @page_number == 1
        menu = FIRST_PAGE_TICKETS_MENU
      elsif has_next_page
        menu = TICKETS_MENU
      else
        menu = LAST_PAGE_TICKETS_MENU
      end

      tickets_menu = @prompt.select('Choose your tickets viewing options?', menu)
      case tickets_menu
      when menu[0]
        @page_number -= 1
      when menu[1]
        @page_number += 1
      when menu[2]
        @is_under_tickets_menu = false
      end
    end
  end
end
