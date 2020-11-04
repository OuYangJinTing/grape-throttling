# frozen_string_literal: true

require 'test_helper'

module Grape
  describe Request do
    let(:request) { Request.allocate }

    it '#enabled_throttle' do
      assert request.respond_to?(:enabled_throttle)
    end

    it '#enabled_throttle=' do
      assert request.respond_to?(:enabled_throttle=)
    end

    it '#id_throttle' do
      assert request.respond_to?(:id_throttle)
    end

    it '#id_throttle=' do
      assert request.respond_to?(:id_throttle=)
    end

    it '#throttle?' do
      assert request.throttle? == true || request.throttle? == false
    end
  end
end
