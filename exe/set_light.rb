#!/usr/bin/env ruby

require 'octokit'
require 'blink1'

class CombinedStatus
  STATES = %i[success pending failure].freeze

  def initialize(repo:, branch:)
    @repo = repo
    @branch = branch
  end

  STATES.each do |state|
    define_method "#{state}?" do
      send(:state) == state
    end
  end

  private

  attr_reader :repo, :branch

  def state
    response[:state].to_sym
  end

  def response
    @response ||= Octokit.combined_status(repo, branch)
  end
end

if ENV.key? 'BLINK1_GITHUB_TOKEN'
  Octokit.configure do |c|
    c.access_token = ENV.fetch('BLINK1_GITHUB_TOKEN')
  end
end

unless ARGV[0]
  p 'Repo is required as the first arg ex: someoneCool/theBestProject'
  exit 1
end

unless ARGV[1]
  p 'Branch is required as the first arg ex: master'
  exit 1
end

combined_status = CombinedStatus.new(repo: ARGV[0], branch: ARGV[1])

Blink1.open do |blink1|
  if combined_status.success?
    blink1.set_rgb(0, 255, 0) # Green
  elsif combined_status.failure?
    blink1.set_rgb(255, 0, 0) # Red
  else
    blink1.set_rgb(255, 255, 0)
  end
end
