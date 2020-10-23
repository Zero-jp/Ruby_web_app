# frozen_string_literal: true

require 'roda'

# Core class
class App < Roda
    # Specifying the path to the root of the application
    opts[:root] = __dir__ # Here it is write that the root of the app is that file
    # Serving static files
    plugin :public

  route do |r|
    # All requests would be processed
    r.public

    r.root do
      'Hello, World!'
    end
  end
end
