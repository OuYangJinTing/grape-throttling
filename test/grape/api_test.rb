# frozen_string_literal: true

require 'test_helper'

module Grape
  describe API do
    include Rack::Test::Methods

    let(:identity) { :grape }
    let(:max_throttle) { 3 }
    let(:app) do
      max = max_throttle

      Class.new(Grape::API).tap do |grape|
        grape.class_eval do
          singleton_class.attr_reader :throttle
          @throttle = use_throttle(
            max: max,
            condition: proc { params[:condition] },
            identity: proc { params[:identity] }
          )

          helpers do
            def overspeed_message
              'Custom overspeed alert message'
            end
          end

          namespace :namespace do
            post :endpoint do
              status(204)
            end
          end
        end
      end
    end

    after { app.throttle.del(identity) }

    it 'should not counter access time and set throttle headers when condition not satisfied' do
      post '/namespace/endpoint', identity: identity
      assert 204, last_response.status
      assert_equal 0, app.throttle.get(identity)
      assert_nil(last_response.headers.keys.find { |item| item.start_with?('X-RateLimit-') })
    end

    it 'should counter access time and set throttle headers when condition satisfied' do
      post '/namespace/endpoint', identity: identity, condition: true
      assert 204, last_response.status
      assert_equal 1, app.throttle.get(identity)
      assert_equal max_throttle, last_response.headers['X-RateLimit-Limit'].to_i
      assert_equal 1, last_response.headers['X-RateLimit-Used'].to_i
      assert_equal max_throttle - 1, last_response.headers['X-RateLimit-Remaining'].to_i
      assert last_response.headers.key?('X-RateLimit-Reset')
    end

    it 'should limit access and set throttle headers when exceeded max throttle' do
      (max_throttle + 1).times { post '/namespace/endpoint', identity: identity, condition: true }
      assert_equal 403, last_response.status
      assert_equal 'Custom overspeed alert message', last_response.body
      assert_equal max_throttle, last_response.headers['X-RateLimit-Limit'].to_i
      assert_equal max_throttle, last_response.headers['X-RateLimit-Used'].to_i
      assert_equal 0, last_response.headers['X-RateLimit-Remaining'].to_i
      assert last_response.headers.key?('X-RateLimit-Reset')
    end
  end
end
