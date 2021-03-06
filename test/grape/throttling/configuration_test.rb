# frozen_string_literal: true

require 'test_helper'

module Grape
  module Throttling
    describe Configuration do
      let(:config) { Configuration.new }

      it '#redis' do
        assert_respond_to config, :redis
      end

      it '#redis=' do
        assert_raises(ArgumentError) { config.redis = nil }
      end

      it '#overspeed_message_method' do
        assert_respond_to config, :overspeed_message_method
      end

      it '#overspeed_message_method=' do
        assert_respond_to config, :overspeed_message_method=
      end
    end
  end
end
