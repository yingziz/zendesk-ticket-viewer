require_relative '../../lib/views/ticket_view'
require_relative '../../lib/models/ticket'
require 'tty/prompt'
require 'pastel'

describe 'TicketsView' do
  before do
    @ticket_view = TicketView.new
  end

  describe '#fetch_ticket_info' do
    before do
      @ticket_with_all_attributes = Ticket.new({
        'id' => 1,
        'external_id' => nil,
        'created_at' => '2021-05-04T01:44:29Z',
        'updated_at' => '2021-05-04T01:44:30Z',
        'type' => 'incident',
        'subject' => 'Sample ticket: Meet the ticket',
        'priority' => 'normal',
        'status' => 'open',
        'description' => 'Sample description.',
        'recipient' => nil,
        'requester_id' => 123
      })
      @ticket_with_some_attributes = Ticket.new({ 'id' => 1, 'status' => nil })
    end

    context "when a ticket contains all required attributes" do
      it 'returns an array of required attributes and values' do
        expect(
          @ticket_view.fetch_ticket_info(@ticket_with_all_attributes)
        ).to eq [
          ['id', 1],
          ['type', 'incident'],
          ['subject', 'Sample ticket: Meet the ticket'],
          ['description', 'Sample description.'],
          ['created_at', '2021-05-04T01:44:29Z'],
          ['updated_at', '2021-05-04T01:44:30Z'],
          ['status', 'open']
        ]
      end
    end

    context "when a ticket only contains some required attributes" do
      it 'display all required attributs & assigns N/A to non-exist attributes' do
        expect(
          @ticket_view.fetch_ticket_info(@ticket_with_some_attributes)
        ).to eq [
          ['id', 1],
          ['type', 'N/A'],
          ['subject', 'N/A'],
          ['description', 'N/A'],
          ['created_at', 'N/A'],
          ['updated_at', 'N/A'],
          ['status', 'N/A']
        ]
      end
    end
  end

  describe '#display' do
    before do
      @nil_ticket = nil
      @ticket = Ticket.new({
        'id' => 1,
        'external_id' => nil,
        'created_at' => '2021-05-04T01:44:29Z',
        'updated_at' => '2021-05-04T01:44:30Z',
        'type' => 'incident',
        'subject' => 'Sample ticket: Meet the ticket',
        'priority' => 'normal',
        'status' => 'open',
        'description' => 'Sample description.',
        'recipient' => nil,
        'requester_id' => 123
      })
    end

    context 'when the given param is nil -- the ticket is not exist' do
      it 'displays warning Ticket cannot be found' do
        expect_any_instance_of(TTY::Prompt)
          .to receive(:warn)
          .with("Sorry, ticket cannot be found. \n")
        @ticket_view.display(@nil_ticket)
      end
    end

    context 'when the ticket is exist' do
      it 'displays Ticket with required attributes' do
        expect_any_instance_of(TTY::Prompt)
          .to receive(:say)
          .and_return(
            'Ticket Details',
            'id: 1',
            'type: incident',
            'subject: Sample ticket: Meet the ticket',
            'description: Sample description.',
            'created_at: 2021-05-04T01:44:29Z',
            'updated_at: 2021-05-04T01:44:30Z',
            'status: open'
          )
        @ticket_view.display(@ticket)
      end
    end
  end
end
