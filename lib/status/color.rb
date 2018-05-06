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

    def initialize(r:, g:, b:)
      self.r = r
      self.g = g
      self.b = b
    end

    def self.from_rgb(rgb)
      new r: rgb[0], g: rgb[1], b: rgb[2]
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

    def dim_by(x)
      factor = 1.0 - x
      self.r *= factor
      self.g *= factor
      self.b *= factor
      self
    end

    def set_blink!
      p rgb
      blink1 = Blink1.new
      blink1.open
      blink1.set_rgb(*rgb)
      blink1.close
    end
  end
end
