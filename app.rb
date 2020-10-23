# frozen_string_literal: true

require 'roda'

# Core class
class App < Roda
    # Specifying the path to the root of the application
    opts[:root] = __dir__ # Here it is write that the root of the app is that file
    # Allows you to customize the application depending on the environment in which it was launched
    plugin :environments

    # Development environment only
    configure :development do
      # Serving static files
      plugin :public
      opts[:serve_static] = true
    end

  route do |r|
    # All requests would be processed
    r.public if opts[:serve_static]

    r.root do
      'Hello, World!'
    end
  end
end
