# frozen_string_literal: true

require 'grape'
require 'redis-namespace'

require 'grape/throttling/counter'
require 'grape/throttling/extension/api'
require 'grape/throttling/extension/request'
require 'grape/throttling/configurable'
require 'grape/throttling/configuration'
require 'grape/throttling/error'
require 'grape/throttling/version'

module Grape
  module Throttling # :nodoc:
    extend Configurable
  end
end
