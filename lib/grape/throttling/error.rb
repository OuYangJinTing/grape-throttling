# frozen_string_literal: true

module Grape
  module Throttling
    class Error < StandardError; end
    class ArgumentError < Error; end
  end
end
