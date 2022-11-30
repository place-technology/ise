module ISE
  class Session
    property base_url : String
    property client : Halite::Client

    HEADERS = {"Accept" => "application/json", "Content-Type" => "application/json"}

    def initialize(@base_url : String, username : String, password : String)
      @client = Halite.basic_auth(user: username, pass: password)
    end

    def request(method : String, url : String, body) : Halite::Response
      url = Path.new(base_url).join(url).to_s

      Log.debug { "Requesting an URL..." }
      Log.debug { "Request method: #{method}" }
      Log.debug { "Request URL: #{url}" }
      Log.debug { "Request body: #{body.to_json}" }

      case method
      when "GET"
        response = send_request(:get, url, body, headers: {"Accept" => "application/json", "Content-Type" => "application/json"})
      when "POST"
        response = send_request(:post, url, body, headers: {"Accept" => "application/json", "Content-Type" => "application/json"})
      else
        raise Exception.new("The request-method type is invalid.")
      end

      Log.debug { "Request response status code: #{response.status_code}" }
      Log.debug { "Request response body: #{response.body}" }

      raise Exception.new("Failed to get a proper response from the server, #{response.status_code}") if (300..599).includes?(response.status_code)

      response
    end

    def get(url : String) : Halite::Response
      request("GET", url, [] of Nil)
    end

    def post(url : String, body) : Halite::Response
      request("POST", url, body)
    end

    private def send_request(method : Symbol, url : String, body, **kwargs)
      context = OpenSSL::SSL::Context::Client.new
      context.verify_mode = OpenSSL::SSL::VerifyMode::NONE

      case method
      when :get
        client.get(url, headers: kwargs[:headers], tls: context)
      when :post
        client.post(url, headers: kwargs[:headers], raw: body.to_json, tls: context)
      else
        raise Exception.new("The request-method type is invalid.")
      end
    end
  end
end
