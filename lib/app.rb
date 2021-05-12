require_relative 'controllers/ticket_controller'
require_relative 'views/tickets_view'
require_relative 'views/ticket_view'
require_relative 'router'
require 'tty/prompt'

EMAIL = 'lacy.zhang@hotmail.com'
ACCESS_TOKEN = 'fqjZkIl9RUeAQRM5PiH7XFZ3hYbpP4UAFGv7CGCU'
WELCOME_MESSAGE = '*** Welcome to the Zendesk Ticker Viewer ***'

@controller = TicketController.new(EMAIL, ACCESS_TOKEN)
router = Router.new(@controller)

prompt = TTY::Prompt.new
prompt.ok(WELCOME_MESSAGE)
# Start the app
while true
  router.run
end
