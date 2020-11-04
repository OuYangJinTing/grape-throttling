# frozen_string_literal: true

module Grape
  module Throttling
    class Counter # :nodoc:
      delegate :set, :del, :expire, :ttl, to: :@redis

      def initialize(expire)
        @expire = expire.try(:to_i).to_i
        env = ENV['RACK_ENV'].presence || 'unknow'
        @redis = Redis::Namespace.new(
          "grape-throttling:#{env}:counter",
          redis: Throttling.config.redis
        )
      end

      def get(key)
        @redis.get(key).to_i
      end

      def incr(key)
        response = begin
          @redis.incr(key)
        rescue Redis::CommandError => e
          del(key) == 1 ? @redis.incr(key) : (raise e)
        end

        response.tap { expire(key, @expire) if response == 1 && @expire.positive? }
      end
    end
  end
end
