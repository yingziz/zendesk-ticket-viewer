require_relative '../../lib/views/tickets_view'

describe 'TicketsView' do
  before do
    @ticket_view = TicketsView.new
  end

  describe '#fetch_ticket_info' do
    before do
      @ticket_with_all_attributes = {
        'id' => 1,
        'external_id' => nil,
        'created_at' => '2021-05-04T01:44:29Z',
        'updated_at' => '2021-05-04T01:44:30Z',
        'type' => 'incident',
        'subject' => 'Sample ticket: Meet the ticket',
        'priority' => 'normal',
        'status' => 'open',
        'recipient' => nil,
        'requester_id' => 123
      }
      @ticket_with_some_attributes = { 'id' => 1 }
    end

    context "when a ticket contains all required attributes" do
      it 'returns an array of required attributes' do
        expect(
          @ticket_view.fetch_ticket_info(@ticket_with_all_attributes)
        ).to eq [1,'Sample ticket: Meet the ticket', 123, '2021-05-04T01:44:29Z', 'normal']
      end
    end

    context "when a ticket only contains some required attributes" do
      it 'assigns nil to non-exist attributes' do
        expect(
          @ticket_view.fetch_ticket_info(@ticket_with_some_attributes)
        ).to eq [1, nil, nil, nil, nil]
      end
    end
  end

  describe '#display' do
    before do
      @empty_tickets = []
      @tickets = [
        { 'id' => 1, 'subject' => 'Sample ticket 1' },
        { 'id' => 2, 'subject' => 'Sample ticket 2' },
        { 'id' => 3, 'subject' => 'Sample ticket 3' },
        { 'id' => 4, 'subject' => 'Sample ticket 4' },
        { 'id' => 5, 'subject' => 'Sample ticket 5' }
      ]
    end

    context 'when the given param is empty' do
      it 'displays table header without content' do
        STDOUT.should_receive(:puts).with(nil)
        @ticket_view.display(@empty_tickets)
      end
    end

    context 'when the given param is no empty' do
      it 'displays table header with content' do
#         STDOUT.should_receive(:puts).with('
# ++----+-----------------+--------------+------------+----------+
# +| id | subject         | requester_id | created_at | priority |
# ++----+-----------------+--------------+------------+----------+
# +| 1  | Sample ticket 1 |              |            |          |
# +| 2  | Sample ticket 2 |              |            |          |
# +| 3  | Sample ticket 3 |              |            |          |
# +| 4  | Sample ticket 4 |              |            |          |
# +| 5  | Sample ticket 5 |              |            |          |
# ++----+-----------------+--------------+------------+----------+')
#         @ticket_view.display(@tickets)
      end
    end

  end
end

