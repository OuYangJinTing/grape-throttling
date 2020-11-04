# frozen_string_literal: true

require 'test_helper'

module Grape
  describe Throttling do
    it 'has a version number' do
      refute_nil VERSION
    end

    it '#config return Configuration' do
      assert Throttling.config.is_a?(Throttling::Configuration)
    end

    it '#configure return Configuration' do
      assert Throttling.configure.is_a?(Throttling::Configuration)
    end
  end
end
