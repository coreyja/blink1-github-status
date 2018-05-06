# frozen_string_literal: true

module Status
  class Color
    DEFINED_COLORS = {
      red: [255, 0, 0],
      green: [0, 255, 0],
      yellow: [255, 255, 0],
      purple: [255, 0, 255]
    }.freeze

    attr_accessor :r, :g, :b

    def initialize(red:, green:, blue:)
      self.r = red
      self.g = green
      self.b = blue
    end

    def self.from_rgb(rgb)
      new red: rgb[0], green: rgb[1], blue: rgb[2]
    end

    DEFINED_COLORS.each do |name, rgb|
      singleton_class.class_eval do
        define_method name do
          from_rgb rgb
        end
      end
    end

    def rgb
      [r, g, b]
    end

    def dim_by(dim_factor)
      multiplication_factor = 1.0 - dim_factor
      self.r *= multiplication_factor
      self.g *= multiplication_factor
      self.b *= multiplication_factor
      self
    end

    def set_blink!
      blink1 = Blink1.new
      blink1.open
      blink1.set_rgb(*rgb)
      blink1.close
    end
  end
end
