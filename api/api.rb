require "roda"
require "json"

class App < Roda
  plugin :default_headers,
    'Access-Control-Allow-Origin' => '*',
    'Access-Control-Allow-Credentials' => 'true',
    'Content-Type' => 'application/json'

  route do |r|
    # GET / request
    r.root do
      @greeting = 'Hello'

      JSON.dump({message: "#{@greeting} API World!"})
    end

    r.on "track" do
      r.is do
        r.post do
          response.status = 200
          '{"tracked": true}'
        end
      end
    end
  end
end
