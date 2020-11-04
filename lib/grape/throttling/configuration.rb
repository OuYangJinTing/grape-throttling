# frozen_string_literal: true

module Grape
  module Throttling
    class Configuration # :nodoc:
      attr_reader :redis

      def initialize
        @redis = ::Redis.new(url: 'redis://localhost:6379/0', driver: :hiredis)
      end

      def redis=(redis)
        raise ArgumentError, 'must be provide redis instance' unless redis.is_a?(::Redis)

        @redis = redis
      end
    end
  end
end
