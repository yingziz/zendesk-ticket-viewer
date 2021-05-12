require_relative '../../lib/controllers/ticket_controller'
require_relative '../../lib/gateways/ticket_gateway'
require_relative '../../lib/views/tickets_view'
require_relative '../../lib/views/ticket_view'

describe 'TicketController' do
  before do
    @ticket_controller = TicketController.new('email', 'token')
  end

  describe '#tickets' do
    context 'when there is next page' do
      it 'returns next page url' do
        response = JSON.parse('{"tickets": "dummy tickets", "next_page": "dummy_url" }')
        expect_any_instance_of(TicketGateway)
          .to receive(:fetch) { response }
        expect_any_instance_of(TicketsView)
          .to receive(:display)
          .with('dummy tickets')
        expect(@ticket_controller.tickets(1))
          .to eq('dummy_url')
      end
    end

    context 'when there is no next page' do
      it 'returns nil' do
        response = JSON.parse('{"tickets": "dummy tickets"}')
        expect_any_instance_of(TicketGateway)
          .to receive(:fetch) { response }
        expect_any_instance_of(TicketsView)
          .to receive(:display)
          .with('dummy tickets')
        expect(@ticket_controller.tickets(1))
          .to eq(nil)
      end
    end
  end

  describe '#ticket' do
    it 'fetches and displays ticket' do
      response = JSON.parse('{"ticket": "dummy ticket" }')
      expect_any_instance_of(TicketGateway)
        .to receive(:fetch) { response }
      expect_any_instance_of(TicketView)
        .to receive(:display)
        .with('dummy ticket')
      @ticket_controller.ticket(1)
    end
  end

end
