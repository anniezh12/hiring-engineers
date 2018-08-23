# config/initializers/datadog-tracer.rb
#
Rails.configuration.datadog_trace = {
  auto_instrument: true,
  auto_instrument_redis: true,
  default_service: 'my-rails-app',
  tracer: Datadog.tracer

}

# Datadog.configure do |c|
#   c.use :rails, service_name: 'my_rails_app' #this will activate auto-instruction for Rails
# end
