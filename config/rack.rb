class MyMiddleware < Merb::Rack::Middleware
  def call(env)
    Merb.logger.debug "MyMiddleware called"
    status, header, response = @app.call(env)
    
    body = ""
    response.each { |part| body << part }
    body << " merboutpost"
    
    [status, header, body]
  end
end


# use Rack::Head to handle HEAD requests properly
use Rack::Head

# Correctly set a content length.
use Merb::Rack::ContentLength

# use PathPrefix Middleware if :path_prefix is set in Merb::Config
if prefix = ::Merb::Config[:path_prefix]
  use Merb::Rack::PathPrefix, prefix
end

# comment this out if you are running merb behind a load balancer
# that serves static files
use Merb::Rack::Static, Merb.dir_for(:public)

use MyMiddleware

# this is our main merb application
run Merb::Rack::Application.new
