# frozen_string_literal: true

module Status
  module Outputs
    class Logger
      def initialize(color)
        @color = color
      end

      def output!
        puts "RGB: #{color.rgb}"
        puts "Hex: #{color.hex}"
        puts "Name: #{color.name}" if color.named?
      end

      private

      attr_reader :color
    end
  end
end
