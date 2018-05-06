# frozen_string_literal: true

require 'blink1'
require 'json'
require 'lifx-faraday'
require 'octokit'

require_relative 'status/color'
require_relative 'status/color_generator'
require_relative 'status/commit'
require_relative 'status/github_query'

require_relative 'status/outputs/blink1'
require_relative 'status/outputs/lifx'
require_relative 'status/outputs/logger'
