# frozen_string_literal: true

require 'test_helper'

module Grape
  module Throttling
    describe Counter do
      let(:expire) { 30.seconds }
      let(:counter) { Counter.new(expire) }
      let(:key) { 'nonexists' }

      after { counter.del(key) }

      it '#set' do
        assert counter.respond_to?(:set)
      end

      it '#del' do
        assert counter.respond_to?(:del)
      end

      it '#expire' do
        assert counter.respond_to?(:expire)
      end

      it '#ttl' do
        assert counter.respond_to?(:ttl)
      end

      describe '#get' do
        it 'should return zero when key no exists' do
          assert_equal 0, counter.get(key)
        end

        it 'should return Numeric' do
          assert counter.get(key).is_a?(Numeric)
        end
      end

      describe '#incr' do
        it 'should set expire when init value' do
          assert_equal 1, counter.incr(key)
          assert_equal expire, counter.ttl(key)
        end

        it 'should not set expire when key already exists' do
          counter.incr(key)
          assert counter.incr(key) != 1
          sleep 1
          assert counter.ttl(key) != expire
        end

        it 'should success call even if redis store value type error' do
          counter.set(key, 'string')
          assert_equal 1, counter.incr(key)
        end
      end
    end
  end
end
