# frozen_string_literal: true

module Grape
  module Throttling
    module Extension
      module Api # :nodoc:
        extend ActiveSupport::Concern

        module ClassMethods # :nodoc:
          # rubocop:disable Style/ClassVars
          def use_throttle(max: 60, expire: 1.day, condition: proc { true }, identity: proc { request.ip }) # rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity
            max = max.try(:to_i).to_i
            raise ArgumentError, 'max must be positive number' unless max.positive?
            raise ArgumentError, 'condition must be Proc' unless condition.is_a?(Proc)
            raise ArgumentError, 'identity must be Proc' unless identity.is_a?(Proc)

            @@throttle = Counter.new(expire)
            @@throttle.define_singleton_method(:max) { max }
            @@throttle.define_singleton_method(:condition) { condition }
            @@throttle.define_singleton_method(:identity) { identity }

            helpers do
              def mixin_throttle_headers(count)
                header('X-RateLimit-Limit', @@throttle.max.to_s)
                header('X-Ratelimit-Used', count.to_s)
                header('X-RateLimit-Remaining', (@@throttle.max - count).to_s)
                header('X-RateLimit-Reset', (Time.now.utc + @@throttle.ttl(request.id_throttle)).to_s)

                header
              end
            end

            before do
              if instance_eval(&@@throttle.condition)
                request.enabled_throttle = true
                request.id_throttle = instance_eval(&@@throttle.identity)
                count = @@throttle.get(request.id_throttle)

                error!('API rate limit exceeded.', 403, mixin_throttle_headers(count)) if count >= @@throttle.max
              end
            end

            after { mixin_throttle_headers(@@throttle.incr(request.id_throttle)) if request.throttle? }

            @@throttle
          end
          # rubocop:enable Style/ClassVars
        end

        Grape::API.include(self)
      end
    end
  end
end
