require 'net/http'
require 'json'

class TicketGateway
  def initialize(email, token)
    @email = email
    @token = token
    @prompt = TTY::Prompt.new
  end

  def fetch(url)
    uri = URI.parse(url)
    request = Net::HTTP::Get.new(uri)
    request.basic_auth("#{@email}/token", @token)

    req_options = {
      use_ssl: uri.scheme == 'https'
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end

    # Not sure why Net::HTTP does not throw an error when code is not 200
    # Maybe I should use a different package?
    # Through error when response code is not 200 and 404
    # If it's 404, ticket is not exist, ticket_view will give warning, but program continues
    if response.code != '200' && response.code != '404'
      raise "Error code: #{response.code}, Error message: #{response.body}"
    end

    JSON.parse(response.body)
  rescue => error
    @prompt.error(error.message)
    exit
  end
end
