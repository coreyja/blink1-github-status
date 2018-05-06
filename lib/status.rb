# frozen_string_literal: true

require 'octokit'
require 'blink1'
require 'json'

require_relative 'status/color'
require_relative 'status/color_generator'
require_relative 'status/commit'
require_relative 'status/github_query'

require_relative 'status/outputs/blink1'
require_relative 'status/outputs/logger'
