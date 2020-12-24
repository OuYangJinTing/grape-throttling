# frozen_string_literal: true

module Grape
  module Throttling
    class Configuration # :nodoc:
      attr_reader :redis, :overspeed_message_method

      def initialize
        @redis = ::Redis.new(url: 'redis://localhost:6379/0', driver: :hiredis)
        @overspeed_message_method = :overspeed_message
      end

      def redis=(redis)
        raise ArgumentError, 'must be provide redis instance' unless redis.is_a?(::Redis)

        @redis = redis
      end

      def overspeed_message_method=(name)
        @overspeed_message_method = name
      end
    end
  end
end
