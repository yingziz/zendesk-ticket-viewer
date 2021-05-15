require 'json'
require_relative '../../lib/controllers/ticket_controller'
require_relative '../../lib/gateways/ticket_gateway'
require_relative '../../lib/models/ticket'
require_relative '../../lib/views/tickets_view'
require_relative '../../lib/views/ticket_view'

describe 'TicketController' do
  before do
    @ticket_controller = TicketController.new('email', 'token')
    @ticket = { 'id' => 1, 'subject' => 'Sample ticket 1' }
    @tickets = [
      { 'id' => 1, 'subject' => 'Sample ticket 1' },
      { 'id' => 2, 'subject' => 'Sample ticket 2' }
    ]
  end

  describe '#tickets' do
    context 'when there is next page' do
      it 'returns next page url' do
        response = JSON.parse({"tickets": @tickets, "next_page": "dummy_url" }.to_json)

        expect_any_instance_of(TicketGateway)
          .to receive(:fetch) { response }
        expect_any_instance_of(TicketsView)
          .to receive(:display) # How to compare two objects?
          # .with([
          #   Ticket.new({ 'id' => 1, 'subject' => 'Sample ticket 1' }),
          #   Ticket.new({ 'id' => 2, 'subject' => 'Sample ticket 2' })
          # ])
        expect(@ticket_controller.tickets(1))
          .to eq('dummy_url')
      end
    end

    context 'when there is no next page' do
      it 'returns nil' do
        response = JSON.parse({"tickets": @tickets}.to_json)

        expect_any_instance_of(TicketGateway)
          .to receive(:fetch) { response }
        expect_any_instance_of(TicketsView)
          .to receive(:display)
          # .with([
          #   Ticket.new({ 'id' => 1, 'subject' => 'Sample ticket 1' }),
          #   Ticket.new({ 'id' => 2, 'subject' => 'Sample ticket 2' })
          # ])
        expect(@ticket_controller.tickets(1))
          .to eq(nil)
      end
    end
  end

  describe '#ticket' do
    it 'fetches and displays ticket' do
      response = JSON.parse({"ticket": @ticket}.to_json)
      expect_any_instance_of(TicketGateway)
        .to receive(:fetch) { response }
      expect_any_instance_of(TicketView)
        .to receive(:display)
        # .with(
        #   Ticket.new({ 'id' => 1, 'subject' => 'Sample ticket 1' }),
        # )
      @ticket_controller.ticket(1)
    end
  end

end
