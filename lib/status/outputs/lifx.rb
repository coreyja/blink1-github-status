# frozen_string_literal: true

module Status
  module Outputs
    class Lifx
      def initialize(selector: 'all')
        @selector = selector
      end

      def available?
        ENV.key?('LIFX_TOKEN')
      end

      def output!(color)
        light.set_state(color: color.hex)
      end

      private

      attr_reader :selector

      def light
        LifxFaraday::Light.new selector: selector
      end
    end
  end
end
