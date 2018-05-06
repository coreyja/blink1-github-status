# frozen_string_literal: true

module Status
  module Outputs
    class Blink1
      def available?
        ::Blink1.enumerate != 0
      end

      def output!(color)
        blink1 = Blink1.new
        blink1.open
        blink1.set_rgb(color.rgb)
        blink1.close
      end
    end
  end
end
