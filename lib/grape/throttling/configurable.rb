# frozen_string_literal: true

module Grape
  module Throttling
    module Configurable # :nodoc:
      def config
        @config ||= Configuration.new
      end

      def configure
        config.tap { yield(config) if block_given? }
      end
    end
  end
end
