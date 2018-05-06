# frozen_string_literal: true

module Status
  module Outputs
    class Logger
      def available?
        true
      end

      def output!(color)
        puts "RGB: #{color.rgb}"
        puts "Hex: #{color.hex}"
        puts "Name: #{color.name}" if color.named?
      end
    end
  end
end
