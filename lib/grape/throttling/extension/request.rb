# frozen_string_literal: true

module Grape
  module Throttling
    module Extension
      module Request # :nodoc:
        extend ActiveSupport::Concern

        included do
          attr_accessor :enabled_throttle, :id_throttle

          def throttle?
            !!enabled_throttle
          end
        end

        Grape::Request.include self
      end
    end
  end
end
