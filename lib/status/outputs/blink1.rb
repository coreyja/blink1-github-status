# frozen_string_literal: true

module Status
  module Outputs
    class Blink1
      def initialize(color)
        @color = color
      end

      def output!
        blink1 = Blink1.new
        blink1.open
        blink1.set_rgb(color.rgb)
        blink1.close
      end

      private

      attr_reader :color
    end
  end
end
