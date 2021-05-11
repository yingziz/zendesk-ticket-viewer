require_relative '../../lib/gateways/ticket_gateway'
require 'net/http'
require 'json'
require 'tty/prompt'

describe 'TicketGateway' do

  describe '#fetch' do
    before do
      @correct_email = 'lacy.zhang@hotmail.com'
      @correct_token = 'fqjZkIl9RUeAQRM5PiH7XFZ3hYbpP4UAFGv7CGCU'
      @incorrect_email = 'zhang@hotmail.com'
      @incorrect_token = 'pP4UAFGv7CGCU'
    end

    context 'when the given email and token is correct' do
      it 'fatches info successfully' do
        ticket_gateway = TicketGateway.new(@correct_email, @correct_token)
        response = Net::HTTPSuccess.new(1.0, '200', 'OK')
        expect(response).to receive(:body) { '{"body": "dummy body" }' }

        expect_any_instance_of(Net::HTTP)
          .to receive(:request) { response }

        expect(
          ticket_gateway.fetch('https://lacyzhang.zendesk.com/api/v2/tickets.json')
        ).to eq JSON.parse('{"body": "dummy body" }')
      end
    end

    context 'when the given email and token is incorrect' do
      it 'should through error message' do
        ticket_gateway = TicketGateway.new(@correct_email, @correct_token)
        response = Net::HTTPError.new('401', 'ERROR')
        expect(response).to receive(:code) { '401' }
        expect(response).to receive(:body) { "Couldn\'t authenticate you" }

        expect_any_instance_of(Net::HTTP)
          .to receive(:request) { response }

        expect(
          ticket_gateway.fetch('https://lacyzhang.zendesk.com/api/v2/tickets.json')
        ).to raise_error('Error code: 401, Error message: "Couldn\'t authenticate you" ')
      end
    end

  end
end
