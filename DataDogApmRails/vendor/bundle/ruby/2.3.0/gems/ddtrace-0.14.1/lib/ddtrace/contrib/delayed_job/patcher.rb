module Datadog
  module Contrib
    module DelayedJob
      # DelayedJob integration
      module Patcher
        include Base
        register_as :delayed_job

        option :service_name, default: 'delayed_job'.freeze
        option :tracer, default: Datadog.tracer

        @patched = false

        class << self
          def patch
            return @patched if patched? || !defined?(::Delayed)

            require 'ddtrace/ext/app_types'
            require_relative 'plugin'

            add_instrumentation(::Delayed::Worker)
            @patched = true
          rescue => e
            Tracer.log.error("Unable to apply DelayedJob integration: #{e}")
            @patched
          end

          def patched?
            @patched
          end

          private

          def add_instrumentation(klass)
            klass.plugins << Plugin
          end
        end
      end
    end
  end
end
